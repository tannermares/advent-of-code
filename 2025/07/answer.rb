#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 07
module Day07
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    grid = deep_dup(GRID)
    splitter_used = 0

    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        break if i == grid.length - 1
        next if %w[. ^].include? cell

        cell_below = grid[i + 1][j]

        if cell_below == '^'
          splitter_used += 1
          grid[i + 1][j - 1] = '|'
          grid[i + 1][j + 1] = '|'
        else
          grid[i + 1][j] = '|'
        end
      end
    end

    splitter_used
  end

  def self.part2
    grid = deep_dup(GRID)
    paths_values = Hash.new(0)
    bottom = []

    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        break if i == grid.length - 1
        next if %w[. ^].include? cell

        cell_below = grid[i + 1][j]
        current_value = paths_values[[j, i]]

        if cell_below == '^'
          grid[i + 1][j - 1] = '|'
          paths_values[[j - 1, i + 1]] += current_value.zero? ? 1 : current_value
          grid[i + 1][j + 1] = '|'
          paths_values[[j + 1, i + 1]] += current_value.zero? ? 1 : current_value
        else
          grid[i + 1][j] = '|'
          paths_values[[j, i + 1]] += current_value
        end

        bottom.push(current_value) if i + 1 == HEIGHT - 1
      end
    end

    bottom.sum
  end

  def self.deep_dup(array)
    array.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end
end
