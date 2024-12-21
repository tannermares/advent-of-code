#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

# Day 20
module Day20
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    _, _, walls = find_maze_positions(GRID)
    possible_cheats = ::Set.new
    cheats = {}
    full_solved = solve_maze_bfs(GRID)

    walls.each do |wall|
      DIRECTIONS.each do |direction|
        next_wall = wall.zip(direction).map(&:sum)
        next_cell = GRID.dig(*next_wall.reverse)
        next unless ['.', 'E'].include?(next_cell)

        possible_cheats << [wall, next_wall]
      end
    end

    possible_cheats.each do |possible_cheat|
      maze = deep_dup(GRID)
      maze[possible_cheat[0][1]][possible_cheat[0][0]] = '.'
      solved = solve_maze_bfs(maze)
      next unless solved

      used_cheat = solved[:path].include?(possible_cheat[0]) && solved[:path].include?(possible_cheat[1]) && solved[:path].index(possible_cheat[0]) == solved[:path].index(possible_cheat[1]) - 1
      steps_saved = full_solved[:steps] - solved[:steps]
      next unless steps_saved.positive? && used_cheat

      cheats[full_solved[:steps] - solved[:steps]] ||= []
      cheats[full_solved[:steps] - solved[:steps]] << possible_cheat
    end

    good_cheats = cheats.select { |key, _| key >= (SAMPLE ? 0 : 100) }
    good_cheats.values.sum(&:length)
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.solve_maze_bfs(maze)
    maze_start, maze_end = find_maze_positions(maze)
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
        next unless ['.', 'E'].include?(next_cell)

        visited << next_position
        queue << [next_position, steps + 1, path + [next_position]]
      end
    end

    nil
  end

  def self.valid_position?(position)
    position[0].between?(1, WIDTH - 2) && position[1].between?(1, HEIGHT - 2)
  end

  def self.find_maze_positions(maze)
    maze_start = nil
    maze_end = nil
    walls = []

    maze.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless valid_position?([j, i])

        maze_start = [j, i] if cell == 'S'
        maze_end = [j, i] if cell == 'E'
        walls << [j, i] if cell == '#'
      end
    end

    [maze_start, maze_end, walls]
  end

  def self.deep_dup(array)
    array.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end
end
