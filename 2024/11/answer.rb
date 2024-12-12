#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 11
module Day11
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  STONES = INPUT.first.split(' ').map(&:to_i)

  def self.part1
    blink_times(25)
  end

  def self.part2
    blink_times(75)
  end

  def self.blink_times(number)
    stones = Hash.new(0)
    STONES.each { |stone| stones[stone] += 1 }
    blink_cache = {}

    number.times do
      next_stones = Hash.new(0)
      stones.each do |stone, count|
        results = blink(stone, blink_cache)
        Array(results).each { |result| next_stones[result] += count }
        stones = next_stones
      end
    end

    stones.values.sum
  end

  def self.blink(stone, cache)
    return cache[stone] if cache.key?(stone)

    result =
      if stone.zero?
        1
      elsif stone.to_s.length.even?
        mid_point = stone.to_s.length / 2
        first = stone.to_s[...mid_point].to_i
        second = stone.to_s[mid_point...].to_i

        [first, second]
      else
        stone * 2024
      end

    cache[stone] = result
    result
  end
end
