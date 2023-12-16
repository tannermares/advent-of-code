#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 13
module Day13
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  ASH = '.'
  ROCK = '#'

  def self.validate_reflection(start_index, end_index, grid)
    return nil if start_index.nil? || end_index.nil?

    distance = end_index - start_index
    return nil if distance.even?

    valid = (1..distance / 2).all? do |n|
      grid[start_index + n] == grid[end_index - n]
    end

    valid ? end_index - (distance / 2) : nil
  end

  def self.invalidate_reflection(start_index, end_index, grid)
    distance = end_index - start_index
    return nil if distance.even?

    invalid = (1..distance / 2).any? do |n|
      grid[start_index + n] != grid[end_index - n]
    end

    invalid ? (start_index.zero? ? end_index : start_index) : nil
  end

  def self.possible_reflections(grid)
    grid.each_with_object([[], []]).with_index do |(row, acc), index|
      acc[0] << index if grid[0] == row && index != 0
      acc[1] << index if grid[grid.length - 1] == row && index != grid.length - 1
    end
  end

  def self.find_invalid_reflections(grid)
    leading_reflections, trailing_reflections = possible_reflections(grid)

    invalid_leading_reflections = leading_reflections.map do |lr|
      invalidate_reflection(0, lr, grid)
    end.compact

    invalid_trailing_reflections = trailing_reflections.map do |tr|
      invalidate_reflection(tr, grid.length - 1, grid)
    end.compact

    [invalid_leading_reflections, invalid_trailing_reflections]
  end

  def self.find_reflection(grid)
    leading_reflections, trailing_reflections = possible_reflections(grid)

    valid_leading_reflection = leading_reflections.map do |lr|
      validate_reflection(0, lr, grid)
    end.compact.first

    valid_trailing_reflection = trailing_reflections.map do |tr|
      validate_reflection(tr, grid.length - 1, grid)
    end.compact.first

    valid_leading_reflection || valid_trailing_reflection || 0
  end

  def self.array_difference(row1, row2)
    row2.map.with_index { |el, index| el == row1[index] ? nil : index }.compact
  end

  def self.fix_reflection(edge_index, grid)
    edge = grid[edge_index]

    edge_reflection_fixes = grid.map.with_index do |row, index|
      array_diff = array_difference(edge, row)
      array_diff.length == 1 ? [index, array_diff.first] : nil
    end.compact

    new_grid = nil
    invalid_reflection_rows = find_invalid_reflections(grid)
    start_index = nil
    end_index = nil

    if edge_reflection_fixes.length.positive?
      edge_reflection_fixes.each do |row, idx|
        new_grid = grid.clone.map(&:clone)
        toggled_fix = new_grid[row][idx] == ASH ? ROCK : ASH
        new_grid[row][idx] = toggled_fix
        start_index = edge_index > row ? row : edge_index
        end_index = edge_index > row ? edge_index : row

        return new_grid unless validate_reflection(start_index, end_index, new_grid).nil?
      end
    end

    return if invalid_reflection_rows.all?(:empty?)

    new_grid = grid.clone.map(&:clone)
    invalid_reflection_rows[edge_index.zero? ? 0 : 1].each do |invalid_reflection_row|
      distance = (edge_index - invalid_reflection_row).abs
      start_index = edge_index > invalid_reflection_row ? invalid_reflection_row : edge_index
      end_index = edge_index > invalid_reflection_row ? edge_index : invalid_reflection_row

      inner_reflection_fixes = (1..distance / 2).flat_map do |n|
        array_diff = array_difference(grid[start_index + n], grid[end_index - n])
        array_diff.length == 1 ? [start_index + n, array_diff.first] : nil
      end.compact

      next if inner_reflection_fixes.empty?

      toggled_fix = new_grid[inner_reflection_fixes.first][inner_reflection_fixes.last] == ASH ? ROCK : ASH
      new_grid[inner_reflection_fixes.first][inner_reflection_fixes.last] = toggled_fix
    end
    return if validate_reflection(start_index, end_index, new_grid).nil?

    new_grid
  end

  def self.find_fixed_reflection(grid)
    original_horizontal_reflection = find_reflection(grid)
    original_vertical_reflection = find_reflection(grid.transpose)

    start_row = fix_reflection(0, grid)
    end_row = fix_reflection(grid.length - 1, grid)
    start_col = fix_reflection(0, grid.transpose)
    end_col = fix_reflection(grid.transpose.length - 1, grid.transpose)

    if start_row
      horizontal_reflection = find_reflection(start_row)
      vertical_reflection = find_reflection(start_row.transpose)
    end

    if end_row
      horizontal_reflection = find_reflection(end_row)
      vertical_reflection = find_reflection(end_row.transpose)
    end

    if start_col
      horizontal_reflection = find_reflection(start_col)
      vertical_reflection = find_reflection(start_col.transpose)
    end

    if end_col
      horizontal_reflection = find_reflection(end_col)
      vertical_reflection = find_reflection(end_col.transpose)
    end

    [
      original_horizontal_reflection == horizontal_reflection ? 0 : horizontal_reflection,
      original_vertical_reflection == vertical_reflection ? 0 : vertical_reflection
    ]
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
    grid_index = 0

    grids = INPUT.each_with_object([]) do |row, acc|
      grid_index += 1 and next if row == "\n"

      acc[grid_index] ||= []
      acc[grid_index] << row.strip.chars
    end

    grids.sum do |grid|
      horizontal_reflection, vertical_reflection = find_fixed_reflection(grid)
      vertical_reflection + 100 * horizontal_reflection
    end
  end
end
