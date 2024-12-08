#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 06
module Day06
  SAMPLE = false
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
    find_path.drop(1).sum do |potential_loop|
      loops?(potential_loop) ? 1 : 0
    end
  end

  def self.loops?(potential_loop)
    loop_grid = deep_dup(GRID)
    loop_direction = 0
    loop_position = find_guard
    loop_grid[potential_loop[1]][potential_loop[0]] = '#'

    visited_positions = ::Set.new
    loop_found = false

    while valid_position?(loop_position)
      if visited_positions.include?([loop_position, loop_direction])
        loop_found = true
        break
      else
        visited_positions.add([loop_position, loop_direction])
      end

      next_loop_position = loop_position.zip(DIRECTIONS[loop_direction]).map { |a, b| a + b }
      break unless valid_position?(next_loop_position)

      if loop_grid[next_loop_position[1]][next_loop_position[0]] == '#'
        loop_direction = (loop_direction + 1) % 4
      else
        loop_position = next_loop_position
      end
    end

    loop_found
  end

  def self.find_path
    guard_position = find_guard
    direction = 0
    visited_positions = ::Set.new

    while valid_position?(guard_position)
      visited_positions.add(guard_position)
      next_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }

      break unless valid_position?(next_position)

      if GRID[next_position[1]][next_position[0]] == '#'
        direction = (direction + 1) % 4
      else
        guard_position = next_position
      end
    end

    visited_positions
  end

  def self.find_guard
    GRID.each_with_index { |row, i| row.each_with_index { |cell, j| return [j, i] if cell == '^' } }
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end

  def self.deep_dup(array)
    array.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end
end
