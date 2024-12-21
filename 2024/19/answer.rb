#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 19
module Day19
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    towels = INPUT[0].strip.split(', ').sort_by(&:length).reverse
    designs = INPUT.drop(2).map(&:strip)

    designs.sum do |design|
      design_pattern = Array.new(design.length + 1, false)
      design_pattern[0] = true

      (0...design.length).each do |i|
        next unless design_pattern[i]

        towels.each do |towel|
          design_pattern[i + towel.length] = true if design[i, towel.length] == towel
        end
      end

      design_pattern.last ? 1 : 0
    end
  end

  def self.part2
    towels = INPUT[0].strip.split(', ').sort_by(&:length).reverse
    designs = INPUT.drop(2).map(&:strip)

    designs.sum do |design|
      design_pattern = Array.new(design.length + 1, [])
      design_pattern[0] = [[]]

      (0...design.length).each do |i|
        next unless design_pattern[i]

        towels.each do |towel|
          next unless design[i, towel.length] == towel

          design_pattern[i + towel.length] += design_pattern[i].map { |path| path + [towel] }
        end
      end

      next 0 unless design_pattern.last.any?

      design_pattern.last.length
    end
  end
end
