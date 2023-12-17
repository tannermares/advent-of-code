#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 14
module Day14
  SAMPLE = false
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

  def self.part1
    grid = INPUT.map { |row| row.strip.chars }
    rolled_grid = grid.transpose.map { |row| sort_rocks_to_front(row.join).split('') }.transpose

    sum = 0
    rolled_grid.each_with_index do |row, index|
      sum += (row.join.count('O') * (rolled_grid.length - index))
    end

    sum
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
