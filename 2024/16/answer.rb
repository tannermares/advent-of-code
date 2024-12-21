#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

# Day 16
module Day16
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    solved = solve_maze_a_star
    solved[:cost]
  end

  def self.part2
    solutions = solve_maze_a_stars
    puts '-' * 50
    p solutions
    puts '-' * 50
    visited = ::Set.new(solutions.flat_map { |sol| sol[:path] })
    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        print visited.include?([j, i]) ? 'O' : cell
      end
      print "\n"
    end

    visited.size
  end

  def self.solve_maze_a_star
    maze_start, maze_end = find_maze_positions
    initial_position = maze_start
    initial_path = [maze_start]
    initial_cost = 0
    initial_direction = [1, 0]
    total_cost = 0
    priority_queue = [[initial_position, initial_path, initial_cost, initial_direction, total_cost]]
    visited = {}

    until priority_queue.empty?
      current_position, path, g_cost, current_direction, = priority_queue.shift

      return { path:, cost: g_cost } if current_position == maze_end

      DIRECTIONS.each do |direction|
        next_position = current_position.zip(direction).map(&:sum)
        next unless valid_position?(next_position)

        next_cell = GRID.dig(*next_position.reverse)
        next unless ['.', 'E'].include?(next_cell)

        rotation_cost = direction == current_direction ? 0 : 1000
        new_g_cost = g_cost + 1 + rotation_cost
        h_cost = manhattan_distance(next_position, maze_end)
        total_cost = new_g_cost + h_cost

        next if visited[[next_position, direction]] && visited[[next_position, direction]] <= new_g_cost

        visited[[next_position, direction]] = new_g_cost
        new_path = path + [next_position]
        priority_queue << [next_position, new_path, new_g_cost, direction, total_cost]
        priority_queue.sort_by! { |(_, _, _, _, total_cost)| total_cost }
      end
    end

    nil
  end

  def self.solve_maze_a_stars
    maze_start, maze_end = find_maze_positions
    initial_position = maze_start
    initial_path = [maze_start]
    initial_cost = 0
    initial_direction = [1, 0]
    total_cost = 0
    priority_queue = [[initial_position, initial_path, initial_cost, initial_direction, total_cost]]
    visited = {}
    solutions = []

    until priority_queue.empty?
      current_position, path, g_cost, current_direction = priority_queue.shift

      if current_position == maze_end
        solutions << { path:, cost: g_cost }
        next
      end

      DIRECTIONS.each do |direction|
        next_position = current_position.zip(direction).map(&:sum)
        next unless valid_position?(next_position)

        next_cell = GRID.dig(*next_position.reverse)
        next unless ['.', 'E'].include?(next_cell)

        rotation_cost = direction == current_direction ? 0 : 1000
        new_g_cost = g_cost + 1 + rotation_cost
        h_cost = manhattan_distance(next_position, maze_end)
        total_cost = new_g_cost + h_cost

        next if visited[[next_position, direction]] && visited[[next_position, direction]] <= new_g_cost

        visited[[next_position, direction]] = new_g_cost
        new_path = path + [next_position]
        priority_queue << [next_position, new_path, new_g_cost, direction, total_cost]
        priority_queue.sort_by! { |(_, _, _, _, total_cost)| total_cost }
      end
    end

    solutions
  end

  def self.find_maze_positions
    maze_start = nil
    maze_end = nil

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        maze_start = [j, i] if cell == 'S'
        maze_end = [j, i] if cell == 'E'
      end
    end

    [maze_start, maze_end]
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end

  def self.manhattan_distance(position1, position2)
    (position1[0] - position2[0]).abs + (position1[1] - position2[1]).abs
  end
end
