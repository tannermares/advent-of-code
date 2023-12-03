#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'input.txt').freeze
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
end

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
