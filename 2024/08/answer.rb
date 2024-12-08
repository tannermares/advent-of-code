#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 08
module Day08
  SAMPLE = false
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
        new_antinodes = find_antinodes(pair[0], pair[1])
        nodes[:antinodes] += new_antinodes
        antinodes += new_antinodes
      end
    end

    antinodes.uniq.filter { |a| valid_antinode?(a) }.count
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.find_antinodes(node, other_node)
    x1, y1 = node
    x2, y2 = other_node

    # Get slope
    dx = x2 - x1
    dy = y2 - y1

    [[x1 - dx, y1 - dy], [x2 + dx, y2 + dy]]
  end

  def self.valid_antinode?(antinode)
    antinode[0].between?(0, WIDTH - 1) && antinode[1].between?(0, HEIGHT - 1)
  end
end
