#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'sample.txt').freeze
INPUT = File.readlines(INPUT_PATH)
SYMBOL_REGEX = Regexp.new(/[^.\d\s]/)

def part1
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

def part2
  INPUT.each_with_index.map do |row, index|
    gear_indexes = row.to_enum(:scan, /\*/).map { Regexp.last_match.offset(0)[0] }

    previous_row = index.zero? ? '' : INPUT[index - 1]
    next_row = INPUT[index + 1].nil? ? '' : INPUT[index + 1]

    gear_indexes.map do |gi|
      gear_buffer_start = gi.zero? ? 0 : gi - 1
      gear_range = gear_buffer_start..(gi + 1)

      previous_adjacent = previous_row[gear_range] || ''
      current_adjacent = row[gear_range]
      next_adjacent = next_row[gear_range] || ''
      adjacent_gears = (previous_adjacent + current_adjacent + next_adjacent).scan(/\d+/)

      if adjacent_gears.length > 1
        adjacent_gears
      else
        0
      end
    end
  end
end

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
