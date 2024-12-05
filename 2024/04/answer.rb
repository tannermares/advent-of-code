#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 04
module Day04
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map(&:strip).map { |row| row.split('') }

  def self.part1
    GRID.map.with_index do |row, i|
      found = 0

      row.each_with_index do |cell, j|
        next unless cell == 'X'

        found += 1 if check_north(i, j)
        found += 1 if check_north_east(i, j)
        found += 1 if check_east(i, j)
        found += 1 if check_south_east(i, j)
        found += 1 if check_south(i, j)
        found += 1 if check_south_west(i, j)
        found += 1 if check_west(i, j)
        found += 1 if check_north_west(i, j)
      end

      found
    end.sum
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.valid_north?(i)
    i - 1 != -1 && i - 2 != -1 && i - 3 != -1
  end

  def self.valid_east?(j)
    j + 1 != GRID[0].length && j + 2 != GRID[0].length && j + 3 != GRID[0].length
  end

  def self.valid_south?(i)
    i + 1 != GRID.length && i + 2 != GRID.length && i + 3 != GRID.length
  end

  def self.valid_west?(j)
    j - 1 != -1 && j - 2 != -1 && j - 3 != -1
  end

  def self.check_north(i, j)
    return false unless valid_north?(i)

    GRID[i - 1][j] == 'M' && GRID[i - 2][j] == 'A' && GRID[i - 3][j] == 'S'
  end

  def self.check_north_east(i, j)
    return false unless valid_north?(i) && valid_east?(j)

    GRID[i - 1][j + 1] == 'M' && GRID[i - 2][j + 2] == 'A' && GRID[i - 3][j + 3] == 'S'
  end

  def self.check_east(i, j)
    return false unless valid_east?(j)

    GRID[i][j + 1] == 'M' && GRID[i][j + 2] == 'A' && GRID[i][j + 3] == 'S'
  end

  def self.check_south_east(i, j)
    return false unless valid_south?(i) && valid_east?(j)

    GRID[i + 1][j + 1] == 'M' && GRID[i + 2][j + 2] == 'A' && GRID[i + 3][j + 3] == 'S'
  end

  def self.check_south(i, j)
    return false unless valid_south?(i)

    GRID[i + 1][j] == 'M' && GRID[i + 2][j] == 'A' && GRID[i + 3][j] == 'S'
  end

  def self.check_south_west(i, j)
    return false unless valid_south?(i) && valid_west?(j)

    GRID[i + 1][j - 1] == 'M' && GRID[i + 2][j - 2] == 'A' && GRID[i + 3][j - 3] == 'S'
  end

  def self.check_west(i, j)
    return false unless valid_west?(j)

    GRID[i][j - 1] == 'M' && GRID[i][j - 2] == 'A' && GRID[i][j - 3] == 'S'
  end

  def self.check_north_west(i, j)
    return false unless valid_north?(i) && valid_west?(j)

    GRID[i - 1][j - 1] == 'M' && GRID[i - 2][j - 2] == 'A' && GRID[i - 3][j - 3] == 'S'
  end
end
