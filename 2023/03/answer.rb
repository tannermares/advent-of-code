#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 3
module Day3
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  SYMBOL_REGEX = Regexp.new(/[^.\d\s]/)

  def self.part1
    INPUT.each_with_index.sum do |row, index|
      part_numbers = row.scan(/\d+/)

      previous_row = index.zero? ? '' : INPUT[index - 1]
      next_row = INPUT[index + 1].nil? ? '' : INPUT[index + 1]

      part_numbers.sum do |pn|
        part_index = row.index(/(?<!\d)#{pn}(?!\d)/)
        part_buffer_start = part_index.zero? ? 0 : part_index - 1
        part_range = part_buffer_start..(part_index + pn.length)

        previous_adjacent = previous_row[part_range] || ''
        current_adjacent = row[part_range]
        next_adjacent = next_row[part_range] || ''

        if !(previous_adjacent + current_adjacent + next_adjacent).scan(SYMBOL_REGEX).empty?
          pn.to_i
        else
          0
        end
      end
    end
  end

  def self.find_numbers_in_row(gears, row, gear_index)
    row.to_enum(:scan, /\d+/).each do
      match = Regexp.last_match
      start_offset = match.offset(0)[0]
      end_offset = match.offset(0)[1]

      gears << match.to_s.to_i if start_offset <= gear_index + 1 && end_offset >= gear_index
    end
  end

  def self.part2
    INPUT.each_with_index.sum do |row, index|
      gear_indexes = row.to_enum(:scan, /\*/).map { Regexp.last_match.offset(0)[0] }

      previous_row = index.zero? ? '' : INPUT[index - 1]
      next_row = INPUT[index + 1].nil? ? '' : INPUT[index + 1]

      gear_indexes.sum do |gi|
        gears = []

        find_numbers_in_row(gears, previous_row, gi)
        find_numbers_in_row(gears, row, gi)
        find_numbers_in_row(gears, next_row, gi)

        if gears.length == 2
          gears.reduce { |acc, n| acc * n }
        else
          0
        end
      end
    end
  end
end
