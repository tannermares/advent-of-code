#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 05
module Day05
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    fresh = 0
    ranges = []

    INPUT.each do |row|
      if row.include?('-')
        first, last = row.split('-').map(&:to_i)
        ranges << [first, last]
      else
        number = row.strip.to_i
        fresh += 1 if ranges.any? { |range| number.between?(*range) }
      end
    end

    fresh
  end

  def self.part2
    ranges = []

    INPUT.each do |row|
      break if row.strip.empty?

      first, last = row.split('-').map(&:to_i)
      ranges << [first, last]
    end

    new_ranges = merge_overlapping_ranges(ranges)

    new_ranges.sum { |f, l| l + 1 - f }
  end

  def self.merge_overlapping_ranges(ranges)
    ranges.sort_by!(&:first)
    merged = [ranges.shift]

    ranges.each do |current|
      last_merged = merged.last

      if last_merged[1] >= current[0]
        last_merged[1] = [last_merged[1], current[1]].max
      else
        merged << current
      end
    end

    merged
  end
end
