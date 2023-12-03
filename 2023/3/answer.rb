#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)
SYMBOL_REGEX = Regexp.new(/[^.\d\w^\s]/)

def part1
  INPUT.each_with_index.sum do |row, index|
    part_numbers = row.scan(/\d{1,3}/)

    part_numbers.sum do |pn|
      part_index = row.index(pn)
      part_start = part_index.positive? ? part_index - 1 : part_index
      part_range = part_start..(part_index + pn.length)

      previous_row = index.positive? ? INPUT[index - 1][part_range] : ''
      current_row = row[part_range]
      next_row = INPUT[index + 1].nil? ? '' : INPUT[index + 1][part_range]

      previous_adjacent = !previous_row.scan(SYMBOL_REGEX).empty?
      current_adjacent = !current_row.scan(SYMBOL_REGEX).empty?
      next_adjacent = !next_row.scan(SYMBOL_REGEX).empty?

      if previous_adjacent || current_adjacent || next_adjacent
        pn.to_i
      else
        0
      end
    end
  end
end

puts "Part 1 Answer: #{part1}"
