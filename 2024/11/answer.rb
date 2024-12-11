#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 11
module Day11
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    stones = INPUT.first.split(' ').map(&:to_i)

    25.times { stones = stones.flat_map { |stone| blink(stone) } }

    stones.length
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.blink(stone)
    if stone.zero?
      1
    elsif stone.to_s.length.even?
      stone_arr = stone.to_s.chars
      mid_point = stone_arr.length / 2
      first = stone_arr[...mid_point].join('').to_i
      second = stone_arr[mid_point...].join('').to_i

      [first, second]
    else
      stone * 2024
    end
  end
end
