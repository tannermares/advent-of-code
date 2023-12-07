#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)

def part1
  seeds = []
  maps = []
  current_map = -1

  INPUT.each do |row|
    seeds = row.split(': ').last.split.map(&:to_i) and next if row.include?('seeds')
    current_map += 1 and next if row.include?('map:')
    next if row == "\n"

    dest, source, length = row.split

    maps[current_map] ||= { destinations: [], lengths: [], sources: [] }
    maps[current_map][:destinations] << dest.to_i
    maps[current_map][:sources] << source.to_i
    maps[current_map][:lengths] << length.to_i
  end

  seeds.map do |seed|
    location = maps.reduce(seed) do |acc, map|
      map[:sources].each_with_index do |source, index|
        next unless (source..(source + map[:lengths][index])).include?(acc)

        acc += map[:destinations][index] - source and break
      end
      acc
    end

    location
  end.min
end

def part2
  seeds = []
  maps = []
  current_map = -1

  INPUT.each do |row|
    seeds = row.split(': ').last.split.map(&:to_i) and next if row.include?('seeds')
    current_map += 1 and next if row.include?('map:')
    next if row == "\n"

    dest, source, length = row.split.map(&:to_i)
    maps[current_map] ||= []
    maps[current_map] << [source, source + length - 1, dest - source]
  end

  ranges = []
  seeds.each_slice(2) { |seed, count| ranges << [seed, seed + count - 1] }

  maps.reduce(ranges) do |acc, adjustments|
    adjustments.reduce(acc) do |accu, adjustment|
      accu.flat_map do |range|
        adjust_range(adjustment, range)
      end
    end.each do |r|
      r[2] = false
    end
  end.map { |i| i[0] }.min
end

def adjust_range(adjustment, range)
  return [range] if range[1] < adjustment[0] || range[0] > adjustment[1] || range[2]

  low = range[0]
  high = range[1]
  new_ranges = []

  if range[0] < adjustment[0]
    range_end = [adjustment[0] - 1, range[1]].min
    new_ranges << [range[0], range_end]
    low = range_end + 1
  end

  if range[1] > adjustment[1]
    range_start = [range[0], adjustment[1] + 1].max
    new_ranges << [range_start, range[1]]
    high = range_start - 1
  end

  if (adjustment[0]..adjustment[1]).cover?(low..high)
    new_start = [low, adjustment[0]].max + adjustment[2]
    new_end = [high, adjustment[1]].min + adjustment[2]
    new_ranges << [new_start, new_end, true]
  end

  new_ranges
end

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
