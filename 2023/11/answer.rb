#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 11
module Day11
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  EMPTY_SPACE = '.'
  GALAXY = '#'

  def self.expand_rows(galaxy)
    galaxy.each_with_object([]) do |row, acc|
      row.uniq.length == 1 ? 2.times { acc << row } : acc << row
    end
  end

  def self.expand_columns(galaxy)
    galaxy.transpose.each_with_object([]) do |row, acc|
      row.uniq.length == 1 ? 2.times { acc << row } : acc << row
    end.transpose
  end

  def self.expand_galaxy(galaxy)
    expanded_rows = expand_rows(galaxy)
    expand_columns(expanded_rows)
  end

  def self.number_galaxies(galaxy)
    galaxy_number = 0
    galaxy.map { |row| row.map { |space| space == '#' ? (galaxy_number += 1) : space } }
  end

  def self.find_coords(galaxy)
    coords = []
    galaxy.each_with_index { |row, x| row.each_with_index { |space, y| space != '.' && coords << [x, y] } }
    coords
  end

  def self.distance(coord1, coord2)
    Math.sqrt(((coord2[0] - coord1[0])**2) + ((coord2[1] - coord1[1])**2))
  end

  def self.grid_distance(coord1, coord2)
    (coord2[0] - coord1[0]).abs + (coord2[1] - coord1[1]).abs
  end

  def self.part1
    galaxy = INPUT.map(&:strip).map { |row| row.split('') }
    expanded_galaxy = expand_galaxy(galaxy)
    numbered_galaxies = number_galaxies(expanded_galaxy)
    coords = find_coords(numbered_galaxies)
    coords.combination(2).sum { |crds| grid_distance(*crds) }
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
