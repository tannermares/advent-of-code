#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

# Day 10
module Day10
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.split('').map(&:to_i) }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    score = 0

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell.zero?

        score += walk_trail(0, [j, i], collection: ::Set.new).size
      end
    end

    score
  end

  def self.part2
    score = 0

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell.zero?

        score += walk_trail(0, [j, i], collection: []).size
      end
    end

    score
  end

  def self.walk_trail(number, position, collection:)
    summits = collection.dup
    directions = DIRECTIONS.dup

    until directions.empty?
      direction = directions.shift
      next_position = position.zip(direction).map { |a, b| a + b }
      next unless valid_position?(next_position)

      next_number = GRID.dig(*next_position.reverse)
      next unless next_number == number + 1

      if next_number == 9
        summits << next_position
      else
        summits += walk_trail(next_number, next_position, collection: collection)
      end
    end

    summits
  end

  def self.valid_position?(position)
    position[0].between?(0, WIDTH - 1) && position[1].between?(0, HEIGHT - 1)
  end
end
