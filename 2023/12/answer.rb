#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 12
module Day12
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.count_segments(line)
    line.split('.').map(&:length).reject(&:zero?)
  end

  def self.find_arrangements(line, combinations, pattern)
    valid_combinations = []

    while combinations.length.positive?
      combination = combinations.pop
      new_line = line.split(/\?+/).zip(combination).flatten.join
      valid_combinations << new_line if count_segments(new_line) == pattern
    end

    valid_combinations.length
  end

  def self.find_combinations(line)
    segments = line.split('.').reject(&:empty?).flat_map { |p| p.split('#') }.reject(&:empty?)
    separate_segments = segments.map do |segment|
      ['#', '.'].repeated_permutation(segment.length).map(&:join)
    end
    separate_segments.first.product(*separate_segments.drop(1))
  end

  def self.part1
    INPUT.sum do |row|
      record, pattern = row.split
      combinations = find_combinations(record)
      find_arrangements(record, combinations, pattern.split(',').map(&:to_i))
    end
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
