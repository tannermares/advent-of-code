#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 20
module Day20
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.cycle(modules)
    low_pulses = 1
    high_pulses = 0

    modules['broadcaster'][''].call(0)

    [low_pulses, high_pulses]
  end

  def self.part1
    low_pulses = 0
    high_pulses = 0

    modules = INPUT.each_with_object({}) do |row, acc|
      module_type_and_name, destinations = row.strip.split(' -> ')
      module_type, name = module_type_and_name.partition(/&|%/).reject(&:empty?)
      acc[name || module_type] = { type: module_type, state: 0, destinations: destinations.split(', ') }
    end

    puts modules.inspect

    1000.times do
      lp, hp = cycle(modules)
      low_pulses += lp
      high_pulses += hp
    end

    low_pulses * high_pulses
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
