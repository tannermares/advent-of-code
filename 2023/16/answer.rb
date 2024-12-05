#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 16
module Day16
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  NORTH = 'N'
  EAST = 'E'
  SOUTH = 'S'
  WEST = 'W'

  DIRECTION_MAPS = {
    '/' => { NORTH => [EAST], EAST => [NORTH], SOUTH => [WEST], WEST => [SOUTH] },
    '\\' => { NORTH => [WEST], EAST => [SOUTH], SOUTH => [EAST], WEST => [NORTH] },
    '|' => { NORTH => [NORTH], EAST => [NORTH, SOUTH], SOUTH => [SOUTH], WEST => [NORTH, SOUTH] },
    '-' => { NORTH => [EAST, WEST], EAST => [EAST], SOUTH => [EAST, WEST], WEST => [WEST] },
    '.' => { NORTH => [NORTH], EAST => [EAST], SOUTH => [SOUTH], WEST => [WEST] }
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
    return false if step.any?(&:negative?)

    grid[step[1]][step[0]]
  rescue NoMethodError
    false
  end

  def self.take_step(paths, grid)
    new_path = []

    paths = paths.map do |path|
      last_step = path[:steps].last
      next_coord = next_coord(last_step)
      valid_space = valid_space(next_coord, grid)

      next { steps: path[:steps], status: 1 } unless valid_space

      new_direction = DIRECTION_MAPS[valid_space][last_step[:direction]]
      new_step = { coord: next_coord, direction: new_direction.first, space: valid_space }
      other_new_step = { coord: next_coord, direction: new_direction.last, space: valid_space }
      already_passed = path[:steps].include?(new_step) || path[:steps].include?(other_new_step)

      next { steps: path[:steps], status: 1 } if already_passed

      new_path = [{ steps: path[:steps] + [other_new_step], status: 0 }] if new_direction.length > 1
      { steps: path[:steps] + [new_step], status: 0 }
    end

    paths + new_path
  end

  def self.count_uniq_paths(paths)
    paths.flat_map { |path| path[:steps].map { |s| s[:coord] } }.uniq.count
  end

  def self.part1
    grid = INPUT.map { |row| row.strip.split('') }
    paths = [{ status: 0, steps: [{ coord: [-1, 0], direction: EAST, space: grid[0][0] }] }]
    paths = take_step(paths, grid) until paths.all? { |path| path[:status].positive? }

    count_uniq_paths(paths) - 1
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
