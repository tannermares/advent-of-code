#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 09
module Day09
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    red_tiles = INPUT.map { |row| row.strip.split(',').map(&:to_i) }
    pairs = []
    red_tiles.repeated_combination(2) { |combination| pairs.push(combination) unless combination.uniq.length == 1 }
    areas = {}
    pairs.each { |pair| areas[pair] = area(*pair) }
    largest = areas.max_by { |_, v| v }

    largest[1]
  end

  def self.part2
    red_tiles = INPUT.map { |row| row.strip.split(',').map(&:to_i) }
    pairs = []

    red_tiles.repeated_combination(2) do |combination|
      if combination.uniq.length != 1 && combination[0][0] != combination[1][0] && combination[0][1] != combination[1][1]
        pairs.push(combination)
      end
    end

    areas = {}
    pairs.each { |pair| areas[pair] = area(*pair) }
    sorted_areas = areas.sort_by { |_, v| -v }
    grid = {}

    red_tiles.push(red_tiles[0]).each_with_index do |tile, index|
      next if index.zero?

      previous_tile = red_tiles[index - 1]

      if tile[0] == previous_tile[0]
        if previous_tile[1] > tile[1]
          previous_tile[1].downto(tile[1]) do |n|
            grid[[tile[0], n]] = 'X'
          end
        else
          previous_tile[1].upto(tile[1]) do |n|
            grid[[tile[0], n]] = 'X'
          end
        end
      elsif previous_tile[0] > tile[0]
        previous_tile[0].downto(tile[0]) do |n|
          grid[[n, tile[1]]] = 'X'
        end
      else
        previous_tile[0].upto(tile[0]) do |n|
          grid[[n, tile[1]]] = 'X'
        end
      end

      grid[[tile[0], tile[1]]] = '#'
      grid[[previous_tile[0], previous_tile[1]]] = '#'
    end

    in_perimeter = nil
    rows = {}

    until in_perimeter
      sorted_areas.each do |pair, area|
        other_corners = other_corners(*pair)
        inclusive = other_corners.all? do |p|
          rows[p[1]] ||= grid.select { |k, _| k[1] == p[1] }.keys.map(&:first)
          p[0].between?(rows[p[1]].min, rows[p[1]].max)
        end

        next unless inclusive

        in_perimeter = area
        break
      end
    end

    in_perimeter
  end

  def self.area(point_one, point_two)
    length = (point_one[0] - point_two[0]).abs
    width = (point_one[1] - point_two[1]).abs

    (length + 1) * (width + 1)
  end

  def self.other_corners(point_one, point_two)
    corner_one = [point_one[0], point_two[1]]
    corner_two = [point_two[0], point_one[1]]

    [corner_one, corner_two]
  end
end
