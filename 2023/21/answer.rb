#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 21
module Day21
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  NORTH = 'N'
  EAST = 'E'
  SOUTH = 'S'
  WEST = 'W'

  DIRECTION_MAPS = {
    NORTH => [NORTH, EAST, WEST],
    EAST => [EAST, NORTH, SOUTH],
    SOUTH => [SOUTH, EAST, WEST],
    WEST => [WEST, NORTH, SOUTH]
  }.freeze

  def self.next_coord(step)
    case step[:direction]
    when NORTH
      [step[:coord][0], step[:coord][1] - 1]
    when EAST
      [step[:coord][0] + 1, step[:coord][1]]
    when SOUTH
      [step[:coord][0], step[:coord][1] + 1]
    when WEST
      [step[:coord][0] - 1, step[:coord][1]]
    else
      raise 'WHAT THE?'
    end
  end

  def self.valid_space(step, grid)
    grid[step[1]][step[0]] == '.'
  end

  def self.take_step(paths, grid, step)
    new_paths = []

    paths.each do |path|
      last_step = path[:steps].last
      next_coord = next_coord(last_step)
      row = grid[next_coord[1] % grid.length]
      converted_coord = [next_coord[0] % row.length, next_coord[1] % grid.length]
      valid_space = valid_space(converted_coord, grid)

      next unless valid_space

      DIRECTION_MAPS[last_step[:direction]].each do |new_direction|
        new_step = { coord: converted_coord, direction: new_direction }
        # already_passed = paths.any? { |p| p[:steps].map { |s| s[:coord] }.include?(converted_coord) }
        # next if already_passed

        new_paths << path.merge(steps: path[:steps] + [new_step])
        next unless step.odd?

        if next_coord == converted_coord
          grid[converted_coord[1]][converted_coord[0]] = 1
        else
          current_space = grid[converted_coord[1]][converted_coord[0]].to_i
          grid[converted_coord[1]][converted_coord[0]] = current_space + 1
        end
      end
    end

    [new_paths, grid]
  end

  def self.part1
    steps = SAMPLE ? 6 : 64
    paths = []
    grid = INPUT.map.with_index do |row, index|
      new_row = row.strip.chars
      starting_index = new_row.index('S')
      if starting_index
        paths.concat(
          [
            { steps: [{ coord: [starting_index, index], direction: NORTH }] },
            { steps: [{ coord: [starting_index, index], direction: EAST }] },
            { steps: [{ coord: [starting_index, index], direction: SOUTH }] },
            { steps: [{ coord: [starting_index, index], direction: WEST }] }
          ]
        )
      end

      new_row
    end

    steps.times { |n| paths, grid = take_step(paths, grid, n) }
    grid.flatten.sum(&:to_i) + 1
  end

  def self.part2
    steps = SAMPLE ? 10 : 26_501_365
    paths = []
    grid = INPUT.map.with_index do |row, index|
      new_row = row.strip.chars
      starting_index = new_row.index('S')
      if starting_index
        paths.concat(
          [
            { steps: [{ coord: [starting_index, index], direction: NORTH }] },
            { steps: [{ coord: [starting_index, index], direction: EAST }] },
            { steps: [{ coord: [starting_index, index], direction: SOUTH }] },
            { steps: [{ coord: [starting_index, index], direction: WEST }] }
          ]
        )
      end

      new_row
    end

    puts "STEPS: #{steps}"
    steps.times { |n| paths, grid = take_step(paths, grid, n) }
    grid.each { |r| puts r.inspect }
    grid.flatten.sum(&:to_i) + 1
  end
end
