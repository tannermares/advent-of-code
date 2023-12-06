#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)

def distances_traveled(time, distance)
  button_holding_range = (0..time)

  button_holding_range.count do |bh_time|
    duration = time - bh_time
    dist = bh_time * duration

    dist > distance
  end
end

def part1
  times = INPUT[0].scan(/\d+/).map(&:to_i)
  distances = INPUT[1].scan(/\d+/).map(&:to_i)

  times.each_with_index.map do |time, index|
    distances_traveled(time, distances[index])
  end.reduce(&:*)
end

def part2
  time = INPUT[0].scan(/\d+/).join.to_i
  distance = INPUT[1].scan(/\d+/).join.to_i

  distances_traveled(time, distance)
end

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
