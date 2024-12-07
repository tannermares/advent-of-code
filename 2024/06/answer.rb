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
    grid, = walk_grid(starting_position: find_guard, starting_direction: 0)
    grid.flatten.count('X')
  end

  def self.part2
    _, loops = walk_grid(
      starting_position: find_guard,
      starting_direction: 0,
      obstacles: find_obstacles
    )
    loops
  end

  def self.potential_loop?(position, direction, obstacles)
    case direction
    when 0
      obstacles.any? { |obstacle| obstacle[1] == position[1] && obstacle[0] > position[0] }
    when 1
      obstacles.any? { |obstacle| obstacle[0] == position[0] && obstacle[1] > position[1] }
    when 2
      obstacles.any? { |obstacle| obstacle[1] == position[1] && obstacle[0] < position[0] }
    when 3
      obstacles.any? { |obstacle| obstacle[0] == position[0] && obstacle[1] < position[1] }
    end
  end

  def self.walk_grid(grid: GRID, starting_position:, starting_direction:, obstacles: [], loops: 0, add_obstacle: false)
    new_grid = deep_dup(grid)
    new_grid[add_obstacle[1]][add_obstacle[0]] = '#' if add_obstacle
    guard_position = starting_position
    direction = starting_direction
    steps = 0

    if steps >= 99
      puts '-' * 50
      puts "HIT 100 STEP LIMIT CHECKING: #{starting_direction} when adding obstacle at #{add_obstacle} going #{starting_direction}"
      puts '-' * 50
    end

    while valid_position?(guard_position) && steps < 100
      next_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      new_grid[guard_position[1]][guard_position[0]] = 'X'

      if steps != 0 && (guard_position == starting_position) && (direction + 1) % 4 == starting_direction
        loops += 1
        break
      end
      break unless valid_position?(next_position)

      if GRID[next_position[1]][next_position[0]] != '#' && obstacles && potential_loop?(guard_position, direction, obstacles)
        _, new_loops = walk_grid(
          grid: GRID,
          starting_position: guard_position,
          add_obstacle: next_position,
          starting_direction: (direction + 1) % 4,
          loops: loops
        )

        loops += new_loops
      end

      if new_grid[next_position[1]][next_position[0]] == '#'
        direction = (direction + 1) % 4
        guard_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      else
        guard_position = next_position
      end

      steps += 1
    end

    [new_grid, loops]
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
