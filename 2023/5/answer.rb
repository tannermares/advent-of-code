#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)

def part1
  seeds = []
  current_map = nil
  maps = {
    'seed-to-soil' => { destinations: [], lengths: [], sources: [] },
    'soil-to-fertilizer' => { destinations: [], lengths: [], sources: [] },
    'fertilizer-to-water' => { destinations: [], lengths: [], sources: [] },
    'water-to-light' => { destinations: [], lengths: [], sources: [] },
    'light-to-temperature' => { destinations: [], lengths: [], sources: [] },
    'temperature-to-humidity' => { destinations: [], lengths: [], sources: [] },
    'humidity-to-location' => { destinations: [], lengths: [], sources: [] }
  }

  INPUT.each do |row|
    seeds = row.split(': ').last.split.map(&:to_i) and next if row.include?('seeds')
    current_map = row.split(' ').first and next if row.include?('map:')
    next if row == "\n"

    dest, source, length = row.split

    maps[current_map][:destinations] << dest.to_i
    maps[current_map][:sources] << source.to_i
    maps[current_map][:lengths] << length.to_i
  end

  seeds.map do |seed|
    soil = seed
    maps['seed-to-soil'][:sources].each_with_index do |source, index|
      if seed == source || (seed > source && seed < source + maps['seed-to-soil'][:lengths][index])
        soil = soil + (maps['seed-to-soil'][:destinations][index] - source)
      end
    end

    fertilizer = soil
    maps['soil-to-fertilizer'][:sources].each_with_index do |source, index|
      if soil == source || (soil > source && soil < source + maps['soil-to-fertilizer'][:lengths][index])
        fertilizer = fertilizer + (maps['soil-to-fertilizer'][:destinations][index] - source)
      end
    end

    water = fertilizer
    maps['fertilizer-to-water'][:sources].each_with_index do |source, index|
      if fertilizer == source || (fertilizer > source && fertilizer < source + maps['fertilizer-to-water'][:lengths][index])
        water = water + (maps['fertilizer-to-water'][:destinations][index] - source)
      end
    end

    light = water
    maps['water-to-light'][:sources].each_with_index do |source, index|
      if water == source || (water > source && water < source + maps['water-to-light'][:lengths][index])
        light = light + (maps['water-to-light'][:destinations][index] - source)
      end
    end

    temperature = light
    maps['light-to-temperature'][:sources].each_with_index do |source, index|
      if light == source || (light > source && light < source + maps['light-to-temperature'][:lengths][index])
        temperature = temperature + (maps['light-to-temperature'][:destinations][index] - source)
      end
    end

    humidity = temperature
    maps['temperature-to-humidity'][:sources].each_with_index do |source, index|
      if temperature == source || (temperature > source && temperature < source + maps['temperature-to-humidity'][:lengths][index])
        humidity = humidity + (maps['temperature-to-humidity'][:destinations][index] - source)
      end
    end

    location = humidity
    maps['humidity-to-location'][:sources].each_with_index do |source, index|
      if humidity == source || (humidity > source && humidity < source + maps['humidity-to-location'][:lengths][index])
        location = location + (maps['humidity-to-location'][:destinations][index] - source)
      end
    end

    location
  end.min
end

def part2
end

puts "Part 1 Answer: #{part1}"
# puts "Part 2 Answer: #{part2}"
