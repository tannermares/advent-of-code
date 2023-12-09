#!/usr/bin/env ruby
# frozen_string_literal: true

SAMPLE = false
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
    nodes[start] = next_step.gsub(/\(|\)/, '').strip.split(', ')
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
  steps = 0
  nodes = {}
  instructions = nil
  z_counts = []
  current_nodes = []

  INPUT.each_with_index do |row, index|
    instructions = row.strip and next if index.zero?
    next if row == "\n"

    start, next_step = row.split(' = ')
    next_step = next_step.gsub(/\(|\)/, '').strip.split(', ')

    nodes[start] = next_step
  end

  current_nodes = nodes.keys.filter { |node| node.end_with?('A') }

  until current_nodes.all? { |node| node.end_with?('Z') }
    instructions.each_char.each do |inst|
      steps += 1

      current_nodes.each_with_index do |node, index|
        next if node.end_with?('Z')

        next_node = inst == 'L' ? nodes[node][0] : nodes[node][1]
        z_counts << steps if next_node.end_with?('Z')
        current_nodes[index] = next_node
      end
    end
  end

  z_counts.reduce(1, :lcm)
end
