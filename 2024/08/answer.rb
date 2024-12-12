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
    find_antinodes(find_resonant_harmonics: false)
  end

  def self.part2
    find_antinodes(find_resonant_harmonics: true)
  end

  def self.find_antinodes(find_resonant_harmonics:)
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
        new_antinodes = find_antinodes_for_pair(pair[0], pair[1], find_resonant_harmonics: find_resonant_harmonics)
        nodes[:antinodes] += new_antinodes
        antinodes += new_antinodes
      end
    end

    pp antinodes.uniq.filter { |a| valid_antinode?(a) }

    antinodes.uniq.filter { |a| valid_antinode?(a) }.count
  end

  def self.find_antinodes_for_pair(node, other_node, find_resonant_harmonics: false)
    x1, y1 = node
    x2, y2 = other_node

    # Get slope
    dx = x2 - x1
    dy = y2 - y1

    new_start = [x1 - dx, y1 - dy]
    new_end = [x2 + dx, y2 + dy]
    antinodes = [new_start, new_end]

    if find_resonant_harmonics
      antinodes += [node, other_node]

      while valid_antinode?(new_start) || valid_antinode?(new_end)
        new_start = [new_start[0] - dx, new_start[1] - dy]
        new_end = [new_end[0] + dx, new_end[1] + dy]
        antinodes += [new_start, new_end]
      end
    end

    antinodes
  end

  def self.valid_antinode?(antinode)
    antinode[0].between?(0, WIDTH - 1) && antinode[1].between?(0, HEIGHT - 1)
  end
end
