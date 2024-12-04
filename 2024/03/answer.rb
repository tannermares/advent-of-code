#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 3
module Day3
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT[0].scan(/mul\((\d{1,3}),(\d{1,3})\)/).map do |(first, second)|
      first.to_i * second.to_i
    end.sum
  end

  def self.part2
    enabled = true
    INPUT[0].scan(/(don't\(\)|do\(\)|mul\((\d{1,3}),(\d{1,3})\))/).map do |(command, first, second)|
      if command == 'do()'
        enabled = true
        next 0
      end

      if command == "don't()"
        enabled = false
        next 0
      end

      enabled ? first.to_i * second.to_i : 0
    end.sum
  end
end
