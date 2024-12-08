#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 08
module Day08
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  HEIGHT = GRID.length
  WIDTH = GRID.first.length

  def self.part1
    frequencies = {}
    antinodes = []

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next if cell == '.'

        frequencies[cell] ||= { coords: [], pairs: [], antinodes: [] }
        frequencies[cell][:coords] << [j, i]
      end
    end

    frequencies.each_value do |nodes|
      nodes[:pairs] = nodes[:coords].combination(2).to_a
      nodes[:pairs].each do |pair|
        nodes[:antinodes] += find_antinodes(pair[0], pair[1])
        antinodes += nodes[:antinodes]
      end
    end

    # puts '-' * 50
    # p antinodes.uniq
    # p antinodes.uniq.filter { |an| valid_antinode?(an) }
    # puts '-' * 50

    antinodes.uniq.filter { |an| valid_antinode?(an) }.count
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.find_antinodes(node, other_node)
    x1, y1 = node
    x2, y2 = other_node

    # Direction Vector
    dx = x2 - x1
    dy = y2 - y1

    distance = Math.sqrt(dx**2 + dy**2)

    # Unit Vector
    ux = (dx / distance)
    uy = dy / distance

    # New Points
    new_x1 = (x1 - distance * ux).to_i
    new_y1 = (y1 - distance * uy).to_i
    new_x2 = (x2 + distance * ux).to_i
    new_y2 = (y2 + distance * uy).to_i

    [[new_x1, new_y1], [new_x2, new_y2]]
  end

  def self.valid_antinode?(antinode)
    antinode[0].between?(0, WIDTH - 1) && antinode[1].between?(0, HEIGHT - 1)
  end
end
