#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 15
module Day15
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH).map(&:strip)
  GRID = INPUT.map(&:chars)
  DIRECTIONS = { '<' => [-1, 0], '^' => [0, -1], '>' => [1, 0], 'v' => [0, 1] }.freeze

  def self.part1
    state = {
      boxes: [],
      directions: [],
      robot: nil,
      walls: []
    }

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        state[:walls] << [j, i] if cell == '#'
        state[:boxes] << [j, i] if cell == 'O'
        state[:robot] = [j, i] if cell == '@'
        state[:directions] << cell if DIRECTIONS.keys.include?(cell)
      end
    end

    state[:directions].each do |direction|
      state[:robot] = move_object(state[:robot], state, direction)
    end

    state[:boxes].sum { |(x, y)| 100 * y + x }
  end

  def self.part2
    state = {
      directions: [],
      boxes: [],
      robot: nil,
      walls: []
    }

    expanded_grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        state[:walls] << [j, i] if cell == '#'
        state[:boxes] << [[j, i], [j + 1, i]] if cell == '['
        state[:robot] = [[j, i], [j, i]] if cell == '@'
      end
    end

    GRID.each do |row|
      row.each do |cell|
        state[:directions] << cell if DIRECTIONS.keys.include?(cell)
      end
    end

    state[:directions].each do |direction|
      new_state = move_object2(state[:robot], deep_dup(state), direction)
      next if new_state.nil?

      state = new_state
      next_robot = shift_coords(state[:robot].first, direction)
      state[:robot] = [next_robot, next_robot]
    end

    state[:boxes].map(&:first).sum { |(x, y)| 100 * y + x }
  end

  def self.move_object(position, state, direction)
    next_position = position.zip(DIRECTIONS[direction]).map(&:sum)
    return position if state[:walls].include?(next_position)

    if (index = state[:boxes].index(next_position))
      state[:boxes][index] = move_object(next_position, state, direction)
      return position if state[:boxes][index] == next_position
    end

    next_position
  end

  def self.move_object2(object, state, direction)
    case direction
    when '<'
      next_position_s = shift_coords(object.first, direction)
      next_position_e = shift_coords(object.last, direction)
      next_object = [next_position_s, next_position_e]

      return nil if state[:walls].include?(next_position_s)

      neighbor_position_s = shift_coords(next_position_s, direction)
      neighbor_object = [neighbor_position_s, next_position_s]

      if (index = state[:boxes].index(neighbor_object))
        return nil if state[:walls].include?(neighbor_position_s)

        new_state = move_object2(neighbor_object, deep_dup(state), direction)
        return nil if new_state.nil? || state[:boxes][index] == new_state[:boxes][index]

        state = new_state
      end

      if (my_index = state[:boxes].index(object))
        state[:boxes][my_index] = next_object
      end

      state
    when '^', 'v'
      next_position_s = shift_coords(object.first, direction)
      next_position_e = shift_coords(object.last, direction)
      next_object = [next_position_s, next_position_e]

      return nil if state[:walls].include?(next_position_s) || state[:walls].include?(next_position_e)

      left_neighbor_index = state[:boxes].find_index { |box| box[1] == next_position_s }
      right_neighbor_index = state[:boxes].find_index { |box| box[1] == next_position_e || box[0] == next_position_e }

      [left_neighbor_index, right_neighbor_index].compact.uniq.each do |idx|
        new_state = move_object2(state[:boxes][idx], deep_dup(state), direction)
        return nil if new_state.nil? || state[:boxes][idx] == new_state[:boxes][idx]

        state = new_state
      end

      if (my_index = state[:boxes].index(object))
        state[:boxes][my_index] = next_object
      end

      state
    when '>'
      next_position_s = shift_coords(object.first, direction)
      next_position_e = shift_coords(object.last, direction)
      next_object = [next_position_s, next_position_e]

      return nil if state[:walls].include?(next_position_e)

      neighbor_position_e = shift_coords(next_position_e, direction)
      neighbor_object = [next_position_e, neighbor_position_e]

      if (index = state[:boxes].index(neighbor_object))
        return nil if state[:walls].include?(neighbor_position_e)

        new_state = move_object2(neighbor_object, deep_dup(state), direction)
        return nil if new_state.nil? || state[:boxes][index] == new_state[:boxes][index]

        state = new_state
      end

      if (my_index = state[:boxes].index(object))
        state[:boxes][my_index] = next_object
      end

      state

    end
  end

  def self.expanded_grid
    expanded_grid = []

    GRID.each_with_index do |row, i|
      next if row.include?('<') || row.include?('>') || row.nil?

      expanded_grid[i] = []

      row.each do |cell|
        case cell
        when '#'
          expanded_grid[i] << '#'
          expanded_grid[i] << '#'
        when 'O'
          expanded_grid[i] << '['
          expanded_grid[i] << ']'
        when '@'
          expanded_grid[i] << '@'
          expanded_grid[i] << '.'
        else
          expanded_grid[i] << '.'
          expanded_grid[i] << '.'
        end
      end
    end

    expanded_grid
  end

  def self.shift_coords(position, direction)
    position.zip(DIRECTIONS[direction]).map(&:sum)
  end

  def self.deep_dup(obj)
    case obj
    when Array
      obj.map { |e| deep_dup(e) }
    when Hash
      obj.transform_values { |v| deep_dup(v) }
    else
      obj.dup rescue obj # `dup` immutable objects safely
    end
  end
end
