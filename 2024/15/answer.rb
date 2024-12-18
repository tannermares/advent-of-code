#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 15
module Day15
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
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
      left_boxes: [],
      right_boxes: [],
      robot: nil,
      walls: [],
    }

    puts '-' * 50
    puts '-' * 50
    puts '------------------START-------------'
    pp expanded_grid
    puts '-' * 50

    expanded_grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        state[:walls] << [j, i] if cell == '#'
        state[:left_boxes] << [j, i] if cell == '['
        state[:right_boxes] << [j, i] if cell == ']'
        state[:robot] = [j, i] if cell == '@'
      end
    end

    GRID.each do |row|
      row.each do |cell|
        state[:directions] << cell if DIRECTIONS.keys.include?(cell)
      end
    end

    puts '-' * 50
    p state
    puts '-' * 50

    expanded_grid.length.times do |i|
      expanded_grid[0].length.times do |j|
        next print '#' if state[:walls].include?([j, i])
        next print '[' if state[:left_boxes].include?([j, i])
        next print ']' if state[:right_boxes].include?([j, i])
        next print '@' if state[:robot] == [j, i]

        print '.'
      end
      print "\n"
    end

    state[:directions].each do |direction|
      move_object2('@', state[:robot], state, direction)
    end

    expanded_grid.length.times do |i|
      expanded_grid[0].length.times do |j|
        next print '#' if state[:walls].include?([j, i])
        next print '[' if state[:left_boxes].include?([j, i])
        next print ']' if state[:right_boxes].include?([j, i])
        next print '@' if state[:robot] == [j, i]

        print '.'
      end
      print "\n"
    end

    state[:left_boxes].sum { |(x, y)| 100 * y + x }
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

  def self.move_object2(cell, position, state, direction)
    next_position = position.zip(DIRECTIONS[direction]).map(&:sum)
    return position if state[:walls].include?(next_position)

    if (index = state[:left_boxes].index(next_position))
      # case direction
      # when '<'
      #   next_lbox_pos = move_object2('[', next_position, state, direction)

      # when '^'
      #   next_lbox_pos = move_object2('[', next_position, state, direction)
      #   next_rbox_pos = move_object2(']', [next_position[0] + 1, next_position[1]], state, direction)

      #   return position if next_lbox_pos == next_position || next_rbox_pos == [next_position[0] + 1, next_position[1]]
      # when '>'
      #   next_lbox2_pos = move_object2('[', next_position, state, direction)
      # when 'v'
      #   next_lbox_pos = move_object2('[', next_position, state, direction)
      #   next_rbox_pos = move_object2(']', [next_position[0] + 1, next_position[1]], state, direction)
      # end

      # state[:left_boxes][index] = next_lbox_pos
      # state[:right_boxes][index] = next_rbox_pos
    end

    next_position
  end

  def self.expanded_grid
    expanded_grid = []

    GRID.each_with_index do |row, i|
      next if row.include?('<') || row.empty?

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
end
