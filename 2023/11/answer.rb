#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 11
module Day11
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  EMPTY_SPACE = '.'
  GALAXY = '#'

  def expand_galaxy(galaxy)
    galaxy.reduce([]).with_index do |(acc, row), index|
      # if index.zero? && row.uniq.length == 1
      #   acc
      # end
      row.map.with_index do |space, index|
        
      end
    end
  end

  def self.part1
    galaxy = INPUT.map(&:strip).map { |row| row.split('') }
    expanded_galaxy = expand_galaxy(galaxy)
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
