#!/usr/bin/env ruby
# frozen_string_literal: true

SAMPLE = true
INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)

def part1
  steps = 0
  nodes = {}
  instructions = nil
  current_node = 'AAA'

  INPUT.each_with_index do |row, index|
    instructions = row.strip and next if index.zero?
    next if row == "\n"

    start, next_step = row.split(' = ')
    next_step = next_step.gsub(/\(|\)/, '').strip.split(', ')

    puts start
    puts next_step.inspect

    nodes[start] = next_step
  end

  while current_node != 'ZZZ'
    instructions.each_char.each do |inst|
      steps += 1
      current_node = inst == 'L' ? nodes[current_node][0] : nodes[current_node][1]
    end
  end

  steps
end

def part2

end
