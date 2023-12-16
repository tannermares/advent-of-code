#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 13
module Day13
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.validate_reflection(start_index, end_index, grid)
    distance = end_index - start_index
    return nil if distance == 2

    valid = (1..distance / 2).all? do |n|
      grid[start_index + n] == grid[end_index - n]
    end

    valid ? end_index - (distance / 2) : nil
  end

  def self.possible_reflections(grid)
    grid.each_with_object([[], []]).with_index do |(row, acc), index|
      acc[0] << index if grid[0] == row && index != 0
      acc[1] << index if grid[grid.length - 1] == row && index != grid.length - 1
    end
  end

  def self.find_reflection(grid)
    leading_reflections, trailing_reflections = possible_reflections(grid)

    valid_leading_reflections = leading_reflections.map do |lr|
      validate_reflection(0, lr, grid)
    end.compact.first

    valid_trailing_reflections = trailing_reflections.map do |tr|
      validate_reflection(tr, grid.length - 1, grid)
    end.compact.first

    valid_leading_reflections || valid_trailing_reflections || 0
  end

  def self.fix_reflection(grid)
    grid.map.with_index do |row, index|
      row.map_with_index do |el, idx|
        el != grid[index + 1][idx]
      end
    end
  end

  def self.part1
    grid_index = 0

    grids = INPUT.each_with_object([]) do |row, acc|
      grid_index += 1 and next if row == "\n"

      acc[grid_index] ||= []
      acc[grid_index] << row.strip.chars
    end

    grids.sum do |grid|
      horizontal_reflection = find_reflection(grid)
      vertical_reflection = find_reflection(grid.transpose)
      vertical_reflection + 100 * horizontal_reflection
    end
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
