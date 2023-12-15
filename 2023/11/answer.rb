#!/usr/bin/env ruby
# frozen_string_literal: true

require 'benchmark'

# Day 11
module Day11
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  EMPTY_SPACE = '.'
  GALAXY = '#'

  def self.expand_rows(galaxy, times = 2)
    expanded_rows = nil
    expanding_rows = Benchmark.measure do
      expanded_rows = galaxy.each_with_object([]) do |row, acc|
        row.uniq.length == 1 ? times.times { acc << row } : acc << row
      end
    end

    puts "Expanding rows: ".ljust(25) + "#{expanding_rows.real.round(2)}".ljust(5) + " seconds"
    expanded_rows
  end

  def self.expand_columns(galaxy, times = 2)
    expanded_columns = nil
    expanding_columns = Benchmark.measure do
      expanded_columns = galaxy.transpose.each_with_object([]) do |row, acc|
        row.uniq.length == 1 ? times.times { acc << row } : acc << row
      end.transpose
    end

    puts "Expanding columns: ".ljust(25) + "#{expanding_columns.real.round(2)}".ljust(5) + " seconds"
    expanded_columns
  end

  def self.expand_galaxy(galaxy, times = 2)
    expanded_rows = expand_rows(galaxy, times)
    expand_columns(expanded_rows, times)
  end

  def self.find_coords(galaxy)
    coords = []
    finding_coords = Benchmark.measure do
      galaxy.each_with_index do |row, x|
        row.each_with_index do |space, y|
          space != '.' && coords << [x, y]
        end
      end
    end

    puts "Finding Coords: ".ljust(25) + "#{finding_coords.real.round(2)}".ljust(5) + " seconds"
    coords
  end

  def self.find_coords_regex(galaxy)
    coords = []
    joined = nil
    joining_galaxy = Benchmark.measure do
      joined = galaxy.map(&:join)
    end
    puts "Joining Galaxy: ".ljust(25) + "#{joining_galaxy.real.round(2)}".ljust(5) + " seconds"

    finding_coords = Benchmark.measure do
      joined.each_with_index do |row, index|
        row.scan(/#/) do
          coords << [index, Regexp.last_match.offset(0).first]
        end
      end
    end

    puts "Finding Coords Regex: ".ljust(25) + "#{finding_coords.real.round(2)}".ljust(5) + " seconds"
    coords
  end

  def self.grid_distance(coord1, coord2)
    (coord2[0] - coord1[0]).abs + (coord2[1] - coord1[1]).abs
  end

  def self.part1
    galaxy = INPUT.map(&:strip).map { |row| row.split('') }
    expanded_galaxy = expand_galaxy(galaxy, 2)
    coords = find_coords(expanded_galaxy)
    coords.combination(2).sum { |crds| grid_distance(*crds) }
  end

  def self.part2(times)
    galaxy = INPUT.map(&:strip).map { |row| row.split('') }
    expanded_galaxy = expand_galaxy(galaxy, times)
    coords = find_coords_regex(expanded_galaxy)
    sum = 0
    summing = Benchmark.measure do
      sum = coords.combination(2).sum { |crds| grid_distance(*crds) }
    end
    puts "Summing: ".ljust(25) + "#{summing.real.round(2)}".ljust(5) + " seconds"
    sum
  end
end
