#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 14
module Day14
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = SAMPLE ? [11, 7] : [101, 107]

  def self.part1
    robots = []
    positions = Hash.new(0)
    quads = Hash.new(0)

    INPUT.each do |row|
      matches = row.scan(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)[0].map(&:to_i)
      robots << { position: [matches[0], matches[1]], velocity: [matches[2], matches[3]] }
      positions[[matches[0], matches[1]]] += 1
    end

    100.times do
      robots.each do |robot|
        next_position = robot[:position].zip(robot[:velocity]).map { |a, b| a + b }

        next_position[0] += GRID[0] if next_position[0].negative?
        next_position[1] += GRID[1] if next_position[1].negative?
        next_position[0] %= GRID[0] if next_position[0] >= GRID[0]
        next_position[1] %= GRID[1] if next_position[1] >= GRID[1]

        positions[robot[:position]] -= 1
        positions[next_position] += 1
        positions.delete(robot[:position]) if positions[robot[:position]].zero?

        robot[:position] = next_position
      end
    end

    positions.each do |pos, count|
      quads[:one] += count if (0...GRID[0] / 2).include?(pos[0]) && (0...GRID[1] / 2).include?(pos[1])
      quads[:two] += count if (GRID[0] / 2 + 1...GRID[0]).include?(pos[0]) && (0...GRID[1] / 2).include?(pos[1])
      quads[:three] += count if (0...GRID[0] / 2).include?(pos[0]) && (GRID[1] / 2 + 1...GRID[1]).include?(pos[1])
      quads[:four] += count if (GRID[0] / 2 + 1...GRID[0]).include?(pos[0]) && (GRID[1] / 2 + 1...GRID[1]).include?(pos[1])
    end

    quads.values.reduce(1) { |acc, num| acc * num }
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
