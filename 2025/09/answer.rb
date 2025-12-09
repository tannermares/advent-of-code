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
    red_tiles.repeated_combination(2) { |combination| pairs.push(combination) unless combination.uniq.length == 1 }
    areas = {}
    pairs.each { |pair| areas[pair] = area(*pair) }
    sorted_areas = areas.sort_by { |_, v| v }
    width = red_tiles.max_by(&:first)[0] + 1
    height = red_tiles.max_by(&:last)[0] + 1
    grid = Array.new(height) { Array.new(width, '.') }
    valid_cells = []

    red_tiles.push(red_tiles[0]).each_with_index do |tile, index|
      next if index.zero?

      previous_tile = red_tiles[index - 1]

      if tile[0] == previous_tile[0]
        if previous_tile[1] > tile[1]
          previous_tile[1].downto(tile[1]) do |n|
            grid[n][tile[0]] = 'X'
            valid_cells.push([tile[0], n])
          end
        else
          previous_tile[1].upto(tile[1]) do |n|
            grid[n][tile[0]] = 'X'
            valid_cells.push([tile[0], n])
          end
        end
      else
        if previous_tile[0] > tile[0]
          previous_tile[0].downto(tile[0]) do |n|
            grid[tile[1]][n] = 'X'
            valid_cells.push([n, tile[1]])
          end
        else
          previous_tile[0].upto(tile[0]) do |n|
            grid[tile[1]][n] = 'X'
            valid_cells.push([n, tile[1]])
          end
        end
      end

      grid[tile[1]][tile[0]] = '#'
      grid[previous_tile[1]][previous_tile[0]] = '#'
    end

    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell == '.'

        previous_cell = grid[i][j - 1]
        next unless valid_position?([i, j - 1], height, width)

        if %w[# X].include?(previous_cell)
          grid[i][j] = 'X'
          valid_cells.push([j, i])
        end

      end
    end

    in_perimeter = nil

    until in_perimeter
      sorted_areas.each do |pair, area|
        points = area_points(*pair)
        in_perimeter = area if points.all? { |p| valid_cells.include?(p) }
      end
    end

    in_perimeter
  end

  def self.area(point_one, point_two)
    length = (point_one[0] - point_two[0]).abs
    width = (point_one[1] - point_two[1]).abs

    (length + 1) * (width + 1)
  end

  def self.valid_position?(position, height, width)
    position[0].between?(0, width - 1) && position[1].between?(0, height - 1)
  end

  # [9,5], [2,3]
  def self.area_points(point_one, point_two)
    points = [point_one, point_two]

    if point_one[0] > point_two[0]
      point_one[0].downto(point_two[0]) do |n|
        if point_one[1] > point_two[1]
          point_one[1].downto(point_two[1]) do |m|
            points.push([n, m])
          end
        else
          point_one[1].upto(point_two[1]) do |m|
            points.push([n, m])
          end
        end
      end
    else
      point_one[0].upto(point_two[0]) do |n|
        if point_one[1] > point_two[1]
          point_one[1].downto(point_two[1]) do |m|
            points.push([n, m])
          end
        else
          point_one[1].upto(point_two[1]) do |m|
            points.push([n, m])
          end
        end
      end
    end

    points.uniq
  end
end
