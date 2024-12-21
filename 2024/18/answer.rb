#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 18
module Day18
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  RANGE = SAMPLE ? 7 : 71
  GRID = Array.new(RANGE, Array.new(RANGE, '.'))
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    grid = deep_dup(GRID)

    INPUT.first(SAMPLE ? 12 : 1024).each do |row|
      x, y = row.strip.split(',').map(&:to_i)
      grid[y][x] = '#'
    end

    solved = solve_maze_bfs(grid)

    solved[:steps]
  end

  def self.part2
    byte = SAMPLE ? 12 : 1014
    solved = true

    while solved
      grid = deep_dup(GRID)

      INPUT.first(byte).each do |row|
        x, y = row.strip.split(',').map(&:to_i)
        grid[y][x] = '#'
      end

      solved = solve_maze_bfs(grid)
      byte += 1 if solved
    end

    INPUT[byte - 1].strip
  end

  def self.deep_dup(array)
    array.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end

  def self.solve_maze_bfs(maze)
    maze_start = [0, 0]
    maze_end = [WIDTH - 1, HEIGHT - 1]
    queue = [[maze_start, 0, [maze_start]]]
    visited = Set.new([maze_start])
    steps = 0

    until queue.empty?
      current_position, steps, path = queue.shift

      return { steps:, path: } if current_position == maze_end

      DIRECTIONS.each do |direction|
        next_position = current_position.zip(direction).map(&:sum)
        next if visited.include?(next_position) || !valid_position?(next_position)

        next_cell = maze.dig(*next_position.reverse)
        next unless ['.'].include?(next_cell)

        visited << next_position
        queue << [next_position, steps + 1, path + [next_position]]
      end
    end

    nil
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end
end
