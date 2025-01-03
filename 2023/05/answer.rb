#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 5
module Day5
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    seeds = []
    maps = []
    current_map = -1

    INPUT.each do |row|
      seeds = row.split(': ').last.split.map(&:to_i) and next if row.include?('seeds')
      current_map += 1 and next if row.include?('map:')
      next if row == "\n"

      dest, source, length = row.split.map(&:to_i)

      maps[current_map] ||= { destinations: [], lengths: [], sources: [] }
      maps[current_map][:destinations] << dest
      maps[current_map][:sources] << source
      maps[current_map][:lengths] << length
    end

    seeds.map do |seed|
      maps.reduce(seed) do |acc, map|
        map[:sources].each_with_index do |source, index|
          acc += map[:destinations][index] - source and break if (source..(source + map[:lengths][index])).include?(acc)
        end
        acc
      end
    end.min
  end

  def self.part2
    seeds = []
    ranges = []
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

    seeds.each_slice(2) { |seed, count| ranges << [seed, seed + count - 1] }

    adjusted_flattened = maps.reduce(ranges) do |acc, adjustments|
      flattened = adjustments.reduce(acc) do |accu, adjustment|
        accu.flat_map { |range| adjust_range(adjustment, range) }
      end

      flattened.each { |r| r[2] = false }
    end

    adjusted_flattened.map { |i| i[0] }.min
  end

  def self.adjust_range(adjustment, range)
    return [range] if range[0] > adjustment[1] || range[1] < adjustment[0] || range[2]

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

    new_start = [low, adjustment[0]].max + adjustment[2]
    new_end = [high, adjustment[1]].min + adjustment[2]
    new_ranges << [new_start, new_end, true]

    new_ranges
  end
end
