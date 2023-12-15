#!/usr/bin/env ruby
# frozen_string_literal: true

require 'benchmark'

# Day 11
module Day11
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  EMPTY_SPACE = '.'

  def self.find_rows_to_expand(galaxy)
    galaxy.each_with_object([]).with_index do |(row, acc), index|
      acc << index if row.uniq.length == 1
    end
  end

  def self.find_cols_to_expand(galaxy)
    galaxy.transpose.each_with_object([]).with_index do |(row, acc), index|
      acc << index if row.uniq.length == 1
    end
  end

  def self.find_coords(galaxy)
    galaxy.each_with_object([]).with_index do |(row, acc), y|
      row.each_with_index do |space, x|
        space != EMPTY_SPACE && acc << [x, y]
      end
    end
  end

  def self.expand_coords(coords, galaxy, times)
    rows_to_expand = find_rows_to_expand(galaxy)
    cols_to_expand = find_cols_to_expand(galaxy)

    coords.map do |x, y|
      row_multiplier = rows_to_expand.count { |n| n < y }
      col_multiplier = cols_to_expand.count { |n| n < x }
      [x + col_multiplier * (times - 1), y + row_multiplier * (times - 1)]
    end
  end

  def self.grid_distance(coord1, coord2)
    (coord2[0] - coord1[0]).abs + (coord2[1] - coord1[1]).abs
  end

  def self.part1
    galaxy = INPUT.map(&:strip).map { |row| row.split('') }
    original_coords = find_coords(galaxy)
    expanded_coords = expand_coords(original_coords, galaxy, 2)
    expanded_coords.combination(2).sum { |crds| grid_distance(*crds) }
  end

  def self.part2
    galaxy = INPUT.map(&:strip).map { |row| row.split('') }
    original_coords = find_coords(galaxy)
    expanded_coords = expand_coords(original_coords, galaxy, 1_000_000)
    expanded_coords.combination(2).sum { |crds| grid_distance(*crds) }
  end
end
