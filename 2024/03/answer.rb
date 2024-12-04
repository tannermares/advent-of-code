#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 3
module Day3
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  PART_1_REGEX = /mul\((\d{1,3}),(\d{1,3})\)/.freeze
  PART_2_REGEX = /(don't\(\)|do\(\)|mul\((\d{1,3}),(\d{1,3})\))/.freeze

  def self.part1
    INPUT.flat_map do |row|
      row.scan(PART_1_REGEX).map do |(first, second)|
        first.to_i * second.to_i
      end
    end.sum
  end

  def self.part2
    enabled = true
    INPUT.flat_map do |row|
      row.scan(PART_2_REGEX).map do |(command, first, second)|
        if command == 'do()'
          enabled = true
          next 0
        end

        if command == "don't()"
          enabled = false
          next 0
        end

        enabled ? first.to_i * second.to_i : 0
      end
    end.sum
  end
end
