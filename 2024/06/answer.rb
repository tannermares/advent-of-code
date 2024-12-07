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
    direction = 0
    guard_position = find_guard

    while valid_position?(*guard_position)
      next_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      grid[guard_position[1]][guard_position[0]] = 'X'

      break unless valid_position?(*next_position)

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
    grid = deep_dup(GRID)
    direction = 0
    guard_position = find_guard

    while valid_position?(*guard_position)
      next_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      grid[guard_position[1]][guard_position[0]] = 'X'

      break unless valid_position?(*next_position)

      if grid[next_position[1]][next_position[0]] == '#'
        direction = (direction + 1) % 4
        guard_position = guard_position.zip(DIRECTIONS[direction]).map { |a, b| a + b }
      else
        guard_position = next_position
      end
    end

    h_runs = find_runs(grid)
    v_runs = find_runs(grid.transpose)
    squares = find_squares(h_runs, v_runs)

    find_bounded_squares(squares)
  end

  def self.find_guard
    GRID.each_with_index { |row, i| row.each_with_index { |cell, j| return [j, i] if cell == '^' } }
  end

  def self.valid_position?(x, y)
    x.between?(0, WIDTH - 1) && y.between?(0, HEIGHT - 1)
  end

  def self.deep_dup(array)
    array.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end

  def self.find_runs(grid)
    runs = {}

    grid.each_with_index do |row, i|
      start = nil

      row.each_with_index do |cell, j|
        if cell == 'X'
          start ||= j
        elsif start
          runs[i] = [start, j - 1] unless start == j - 1
          start = nil
        end
      end

      runs[i] = [start, row.length - 1] if start
    end

    runs
  end

  def self.find_squares(h_runs, v_runs)
    squares = []

    h_runs.each do |row, top_h_run|
      (top_h_run[0] + 1..top_h_run[1]).each do |i|
        left_v_run = v_runs[top_h_run[0]]
        right_v_run = v_runs[i]

        next unless left_v_run && right_v_run
        next unless left_v_run[0] <= row && right_v_run[0] <= row

        bottom_row_max = [left_v_run[1], right_v_run[1]].min

        (row + 1..bottom_row_max).each do |j|
          bottom_h_run = h_runs[j]

          next unless bottom_h_run
          next unless bottom_h_run[0] <= top_h_run[0] && i <= bottom_h_run[1]

          squares << [
            [row, top_h_run[0]],
            [row, i],
            [j, i],
            [j, top_h_run[0]]
          ]
        end
      end
    end

    squares
  end

  def self.find_bounded_squares(squares)
    squares.sum do |square|
      obstructions = 0
      obstructions += 1 if GRID[square[0][0] - 1][square[0][1]] == '#'
      obstructions += 1 if GRID[square[1][0]][square[1][1] + 1] == '#'
      obstructions += 1 if GRID[square[2][0] + 1][square[2][1]] == '#'
      obstructions += 1 if GRID[square[3][0]][square[3][1] - 1] == '#'
      obstructions == 3 ? 1 : 0
    end
  end
end
