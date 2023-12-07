#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'sample.txt').freeze
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

  # seeds
  # [[79, 92], [55, 67]]

  # seed to soil
  # 98-99 -> -48
  # 50-97 -> +2
  #------------
  # output: [[81,94], [57..69]]

  # soil-to-fert
  # 15-51 -> -15
  # 52-53 -> -15
  # 0-14  -> +39
  #------------
  # output: [(81..94), (57..69)]

  # fert-to-water
  # 53-60 -> -4
  # 11-52 -> -11
  # 0-6   -> 42
  # 7-10  -> 50
  #-----------
  # (57..60) -4
  # (61..69) 0
  # output: [(81..94), (53..56), (61..69)]

  # water-to-light
  # 18-24 -> 70
  # 25-94 -> -7
  #------------
  # (81..94) -7
  # (53..56) -7
  # (61..69) -7
  # output: [(74..87), (46..49), (54..62)]

  # light-to-temperature
  # 77-99 -> -32
  # 45-63 -> 36
  # 64-76 -> 4
  #-------------
  # (74..76) +4
  # (77..87) -32
  # (46..49) +36
  # (54..62) +36
  # output: [(78..80), (45..55), (82..85), (90..98)]

  # temp-to-hum
  # 69   -> -69
  # 0-68 -> +1
  #-----------
  # (78..80) 0
  # (45..55) +1
  # (82..85) 0
  # (90..98) 0
  # output: [(78..80), (46..56), (82..85), (90..98)]

  # hum-to-loc
  # 56-92 -> +4
  # 93-96 -> -37
  #-----------
  # (78..80) +4
  # (46..55) 0
  # (56)     +4
  # (82..85) +4
  # (90..92) +4
  # (93..96) -37
  # (97..98) 0
  # output: [(82..84), (46..55), (60), (86..89), (94..96), (56..59), (97..98)]

  # you wind up building a source range into one or more destination ranges as you apply each entry in the map.

  ranges = []
  seeds.each_slice(2) { |seed, count| ranges << [seed, seed + count] }

  maps.each do |map|
    # adjustment = [[81, 94], [53, 56], (61..69)]
    map.each do |adjustment|
      # ranges -> [[79, 92], [55, 67]]
      ranges.each do |range|
        # potentially return multiple arrays
      end
    end
  end

  ranges.flatten.min
end

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
