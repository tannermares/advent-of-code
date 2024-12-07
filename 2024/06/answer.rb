#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 06
module Day06
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    grid = deep_dup(GRID)
    guard_position = find_guard
    direction = 0

    while valid_position?(guard_position)
      next_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      grid[guard_position[1]][guard_position[0]] = 'X'

      break unless valid_position?(next_position)

      if grid[next_position[1]][next_position[0]] == '#'
        direction = (direction + 1) % 4
        guard_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      else
        guard_position = next_position
      end
    end

    grid.flatten.count('X')
  end

  def self.part2
    total_loops = find_potential_loops.sum do |potential_loop|
      loops?(potential_loop) ? 1 : 0
    end

    total_loops
  end

  def self.loops?(potential_loop)
    loop_grid = deep_dup(GRID)
    old_guard = find_guard

    loop_direction = potential_loop[:direction]
    loop_position = potential_loop[:starting]

    loop_grid[old_guard[1]][old_guard[0]] = '.'
    loop_grid[potential_loop[:obstacle][1]][potential_loop[:obstacle][0]] = 'O'
    loop_grid[loop_position[1]][loop_position[0]] = '^'

    visited_positions = Set.new
    loop_found = false
    step = 0

    while valid_position?(loop_position)
      if visited_positions.include?([loop_position, loop_direction])
        # puts '-' * 50
        # puts 'LOOP FOUND'
        # p potential_loop
        # pp loop_grid
        # puts '-' * 50
        loop_found = true
        break
      else
        visited_positions.add([loop_position, loop_direction])
      end

      if step >= 10_000
        over_limits << potential_loop
        over_limit += 1
        break
      end

      next_loop_position = loop_position.zip(DIRECTIONS[loop_direction]).map { |a, b| a + b }
      break unless valid_position?(next_loop_position)

      if loop_grid[next_loop_position[1]][next_loop_position[0]] == '#' || loop_grid[next_loop_position[1]][next_loop_position[0]] == 'O'
        loop_direction = (loop_direction + 1) % 4
        # next_loop_position = loop_position.zip(DIRECTIONS[loop_direction]).map { |a, b| a + b }
      else
        loop_position = next_loop_position
      end

      step += 1
    end

    loop_found
  end

  def self.potential_loop?(position, direction, obstacles)
    case direction
    when 0
      obstacles.any? { |obstacle| obstacle[1] == position[1] && obstacle[0] > position[0] + 1 }
    when 1
      obstacles.any? { |obstacle| obstacle[0] == position[0] && obstacle[1] > position[1] + 1}
    when 2
      obstacles.any? { |obstacle| obstacle[1] == position[1] && obstacle[0] < position[0] - 1 }
    when 3
      obstacles.any? { |obstacle| obstacle[0] == position[0] && obstacle[1] < position[1] - 1 }
    end
  end

  def self.find_potential_loops
    guard_position = find_guard
    direction = 0
    potential_loops = []
    obstacles = find_obstacles

    while valid_position?(guard_position)
      next_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }

      break unless valid_position?(next_position)

      if GRID[next_position[1]][next_position[0]] != '#' && potential_loop?(guard_position, direction, obstacles)
        simulated_loop = { obstacle: next_position, starting: guard_position, direction: direction }
        potential_loops << simulated_loop
      end

      if GRID[next_position[1]][next_position[0]] == '#'
        direction = (direction + 1) % 4
        guard_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      else
        guard_position = next_position
      end
    end

    potential_loops
  end

  def self.find_guard
    GRID.each_with_index { |row, i| row.each_with_index { |cell, j| return [j, i] if cell == '^' } }
  end

  def self.find_obstacles
    obstacles = []
    GRID.each_with_index { |row, i| row.each_with_index { |cell, j| obstacles << [j, i] if cell == '#' } }
    obstacles
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end

  def self.deep_dup(array)
    array.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end
end
