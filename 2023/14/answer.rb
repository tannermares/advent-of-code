#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 14
module Day14
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.sort_rocks_to_front(row)
    square_rock_indexes = row.to_enum(:scan, /#/).map { Regexp.last_match.offset(0).first }
    removed_sqare_rocks = row.split('#')

    sort_rocks = removed_sqare_rocks.map do |sub_row|
      sub_row.split('').sort_by { |n| [n == 'O' ? 0 : 1, n] }.join
    end.join

    square_rock_indexes.each { |sr| sort_rocks.insert(sr,'#') }
    sort_rocks
  end

  def self.roll_north(grid)
    grid.transpose.map { |row| sort_rocks_to_front(row.join).split('') }.transpose
  end

  def self.roll_west(grid)
    grid.map { |row| sort_rocks_to_front(row.join).split('') }
  end

  def self.roll_south(grid)
    grid.transpose.map { |row| sort_rocks_to_front(row.reverse.join).split('').reverse }.transpose
  end

  def self.roll_east(grid)
    grid.map { |row| sort_rocks_to_front(row.reverse.join).split('').reverse }
  end

  def self.cycle(grid)
    grid = roll_north(grid)
    grid = roll_west(grid)
    grid = roll_south(grid)
    roll_east(grid)
  end

  def self.sum_grid(grid)
    sum = 0
    grid.each_with_index do |row, index|
      sum += (row.join.count('O') * (grid.length - index))
    end
    sum
  end

  def self.part1
    grid = INPUT.map { |row| row.strip.chars }
    rolled_grid = roll_north(grid)
    sum_grid(rolled_grid)
  end

  def self.part2
    grid = INPUT.map { |row| row.strip.chars }
    cycled_grid = nil
    # 1_000_000_000.times { cycled_grid = cycle(grid) }
    1.times { cycled_grid = cycle(grid) }
    sum_grid(cycled_grid)
  end
end
