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
        next unless acc >= source && acc < source + map[:lengths][index]

        acc += map[:destinations][index] - source and break
      end

      acc
    end

    location
  end.min
end

def part2
end

puts "Part 1 Answer: #{part1}"
# puts "Part 2 Answer: #{part2}"
