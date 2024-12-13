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
  FULL_DIRECTIONS = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].freeze
  CORNER_MAP = {
    0b111_11_111 => 0,
    0b000_00_000 => 4,
    0b000_11_000 => 0,
    0b010_00_010 => 0,
    0b000_01_010 => 2,
    0b010_01_000 => 2,
    0b000_10_010 => 2,
    0b010_10_000 => 2,
    0b000_11_100 => 0,
    0b000_10_000 => 2,
    0b011_00_011 => 0,
    0b010_01_010 => 2,
    0b100_11_100 => 0,
    0b100_11_000 => 0,
    0b000_01_000 => 2,
    0b000_01_011 => 1,
    0b000_11_111 => 0,
    0b000_11_110 => 1,
    0b000_11_001 => 0,
    0b001_11_000 => 0,
    0b011_11_000 => 1,
    0b111_11_000 => 0,
    0b111_10_110 => 1,
    0b110_10_000 => 1,
    0b011_01_000 => 1,
    0b110_00_010 => 0,
    0b010_00_110 => 0,
    0b010_10_010 => 0,
    0b110_10_110 => 0,
    0b001_11_111 => 0,
    0b100_01_011 => 1,
    0b010_10_110 => 0,
    0b011_01_111 => 0,
    0b011_00_010 => 0,
    0b011_01_010 => 1,
    0b011_01_011 => 0,
    0b110_10_001 => 1,
    0b111_11_100 => 0,
    0b000_10_110 => 1,
    0b011_01_100 => 1,
    0b001_10_110 => 1,
    0b010_00_011 => 0,
    0b110_10_111 => 0,
    0b110_11_100 => 1,
    0b100_10_000 => 2,
    0b111_01_010 => 1,
    0b111_11_011 => 1,
    0b111_11_001 => 0,
    0b011_00_000 => 2,
    0b000_10_111 => 1,
    0b011_01_110 => 1,
    0b011_10_100 => 2,
    0b001_01_110 => 2,
    0b001_11_010 => 2,
    0b111_00_011 => 0,
    0b010_01_001 => 2,
    0b100_10_010 => 2,
    0b110_00_000 => 2,
    0b000_01_001 => 2,
    0b110_00_110 => 0,
    0b110_10_100 => 1,
    0b111_11_010 => 2,
    0b011_01_001 => 1,
    0b111_00_000 => 2,
    0b011_11_111 => 1,
    0b110_11_110 => 2,
    0b100_11_101 => 0,
    0b000_00_110 => 2,
    0b010_10_011 => 2,
    0b110_01_011 => 1,
    0b100_10_110 => 1,
    0b010_00_000 => 2,
    0b001_01_001 => 2,
    0b001_01_011 => 1,
    0b000_00_011 => 2,
    0b010_01_111 => 1,
    0b100_11_111 => 0,
    0b110_11_101 => 1,
    0b111_11_110 => 1,
    0b111_10_010 => 1,
    0b000_00_010 => 2
  }.freeze

  def self.part1
    garden_map = {}

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        garden_map[cell] ||= []
        next if garden_map[cell]&.any? { |plot| plot[:locations].include?([j, i]) }

        garden_map[cell] << walk_grid(cell, [j, i], [[j, i]])
      end
    end

    puts '-' * 50
    p garden_map
    puts '-' * 50

    garden_map.values.sum do |plots|
      plots.sum do |plot|
        plot[:walls] * plot[:locations].length
      end
    end
  end

  def self.part2
    pp CORNER_MAP
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
        plot[:corners] * plot[:locations].length
      end
    end
  end

  def self.walk_grid(cell, position, locations)
    directions = DIRECTIONS.dup
    walls = 4
    corners = count_corners(cell, position)

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
      corners += next_plot[:corners]
    end

    { walls: walls, locations: locations.uniq, corners: corners }
  end

  def self.count_corners(cell, position)
    corner_bits = 0b00000000

    FULL_DIRECTIONS.each_with_index do |direction, index|
      next_position = position.zip(direction).map { |a, b| a + b }

      next unless valid_position?(next_position)

      next_cell = GRID.dig(*next_position.reverse)
      next unless next_cell == cell

      bit_index = FULL_DIRECTIONS.length - 1 - index
      corner_bits |= (1 << bit_index)
    end

    if CORNER_MAP[corner_bits].nil?
      p [position, "0b#{corner_bits.to_s(2).rjust(8,'0')}"]
    end

    CORNER_MAP[corner_bits].to_i
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end
end
