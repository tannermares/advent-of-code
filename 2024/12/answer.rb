#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 12
module Day12
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    garden_map = {}

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        garden_map[cell] ||= []
        next if garden_map[cell]&.any? { |plot| plot[:locations].include?([j, i]) }

        garden_map[cell] << walk_grid(cell, [j, i], [[j, i]])
      end
    end

    garden_map.values.sum do |plots|
      plots.sum do |plot|
        plot[:walls] * plot[:locations].length
      end
    end
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.walk_grid(cell, position, locations)
    directions = DIRECTIONS.dup
    walls = 4

    until directions.empty?
      direction = directions.shift
      next_position = position.zip(direction).map { |a, b| a + b }

      next unless valid_position?(next_position)
      next walls -= 1 if locations.include?(next_position)

      next_cell = GRID.dig(*next_position.reverse)
      next unless next_cell == cell

      locations << next_position
      walls -= 1

      next_plot = walk_grid(cell, next_position, locations)

      walls += next_plot[:walls]
      locations += next_plot[:locations]
    end

    { walls: walls, locations: locations.uniq }
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end
end
