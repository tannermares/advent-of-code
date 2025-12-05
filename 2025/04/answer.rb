#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 04
module Day04
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  FULL_DIRECTIONS = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].freeze

  def self.part1
    accessible_rolls = 0

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell == '@'

        adjacent_rolls = 0

        FULL_DIRECTIONS.each do |direction|
          next_position = [j, i].zip(direction).map(&:sum)
          next unless valid_position?(next_position)

          next_cell = GRID.dig(*next_position.reverse)
          next unless next_cell == '@'

          adjacent_rolls += 1
          break if adjacent_rolls == 4
        end

        accessible_rolls += 1 if adjacent_rolls < 4
      end
    end

    accessible_rolls
  end

  def self.part2
    grid = deep_dup(GRID)
    accessible_rolls = 0

    loop do
      rolls_to_remove = []

      grid.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          next unless cell == '@'

          adjacent_rolls = 0

          FULL_DIRECTIONS.each do |direction|
            next_position = [j, i].zip(direction).map(&:sum)
            next unless valid_position?(next_position)

            next_cell = grid.dig(*next_position.reverse)
            next unless next_cell == '@'

            adjacent_rolls += 1
            break if adjacent_rolls == 4
          end

          if adjacent_rolls < 4
            rolls_to_remove << [j, i]
            accessible_rolls += 1
          end
        end
      end

      break if rolls_to_remove.empty?

      rolls_to_remove.each do |position|
        grid[position[1]][position[0]] = '.'
      end
    end

    accessible_rolls
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end

  def self.deep_dup(array)
    array.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end
end
