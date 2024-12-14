#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 14
module Day14
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = SAMPLE ? [11, 7] : [101, 103]
  FIRST_X = (0...GRID[0] / 2)
  SECOND_X = (GRID[0] / 2 + 1...GRID[0])
  FIRST_Y = (0...GRID[1] / 2)
  SECOND_Y = (GRID[1] / 2 + 1...GRID[1])
  EASTER_EGG = [
    '1111111111111111111111111111111',
    '1.............................1',
    '1.............................1',
    '1.............................1',
    '1.............................1',
    '1..............1..............1',
    '1.............111.............1',
    '1............11111............1',
    '1...........1111111...........1',
    '1..........111111111..........1',
    '1............11111............1',
    '1...........1111111...........1',
    '1..........111111111..........1',
    '1.........11111111111.........1',
    '1........1111111111111........1',
    '1..........111111111..........1',
    '1.........11111111111.........1',
    '1........1111111111111........1',
    '1.......111111111111111.......1',
    '1......11111111111111111......1',
    '1........1111111111111........1',
    '1.......111111111111111.......1',
    '1......11111111111111111......1',
    '1.....1111111111111111111.....1',
    '1....111111111111111111111....1',
    '1.............111.............1',
    '1.............111.............1',
    '1.............111.............1',
    '1.............................1',
    '1.............................1',
    '1.............................1',
    '1.............................1',
    '1111111111111111111111111111111'
  ].freeze

  def self.part1
    robots = []
    positions = Hash.new(0)
    quads = Hash.new(0)

    INPUT.each do |row|
      matches = row.scan(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)[0].map(&:to_i)
      robots << { position: [matches[0], matches[1]], velocity: [matches[2], matches[3]] }
      positions[[matches[0], matches[1]]] += 1
    end

    robots.each do |robot|
      next_position = robot[:position].zip(robot[:velocity].map { |n| n * 100 }).map(&:sum)

      next_position[0] %= GRID[0] if next_position[0].negative?
      next_position[1] %= GRID[1] if next_position[1].negative?
      next_position[0] %= GRID[0] if next_position[0] >= GRID[0]
      next_position[1] %= GRID[1] if next_position[1] >= GRID[1]

      positions[robot[:position]] -= 1
      positions[next_position] += 1
      positions.delete(robot[:position]) if positions[robot[:position]].zero?

      robot[:position] = next_position
    end

    positions.each do |pos, count|
      next quads[:one] += count if FIRST_X.include?(pos[0]) && FIRST_Y.include?(pos[1])
      next quads[:two] += count if SECOND_X.include?(pos[0]) && FIRST_Y.include?(pos[1])
      next quads[:three] += count if FIRST_X.include?(pos[0]) && SECOND_Y.include?(pos[1])

      quads[:four] += count if SECOND_X.include?(pos[0]) && SECOND_Y.include?(pos[1])
    end

    quads.values.reduce(1) { |acc, num| acc * num }
  end

  def self.part2
    return if SAMPLE

    robots = []
    positions = Hash.new(0)

    INPUT.each do |row|
      matches = row.scan(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)[0].map(&:to_i)
      robots << { position: [matches[0], matches[1]], velocity: [matches[2], matches[3]] }
      positions[[matches[0], matches[1]]] += 1
    end

    seconds = 1
    easter_egg = 0

    loop do
      robots.each do |robot|
        next_position = robot[:position].zip(robot[:velocity]).map(&:sum)

        next_position[0] %= GRID[0] if next_position[0].negative?
        next_position[1] %= GRID[1] if next_position[1].negative?
        next_position[0] %= GRID[0] if next_position[0] >= GRID[0]
        next_position[1] %= GRID[1] if next_position[1] >= GRID[1]

        positions[robot[:position]] -= 1
        positions[next_position] += 1
        positions.delete(robot[:position]) if positions[robot[:position]].zero?

        robot[:position] = next_position
      end

      GRID[1].times do |n|
        row = ''
        GRID[0].times do |m|
          row += positions[[m, n]].zero? ? '.' : positions[[m, n]].to_s
        end

        next unless row.include?(EASTER_EGG[easter_egg])
        break if easter_egg == EASTER_EGG.length - 1

        easter_egg += 1
      end

      break if easter_egg == EASTER_EGG.length - 1

      easter_egg = 0
      seconds += 1
    end

    seconds
  end
end
