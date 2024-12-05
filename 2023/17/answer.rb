#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 17
module Day17
  SAMPLE = false
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
    return 0 if step.any?(&:negative?)

    grid[step[1]][step[0]].to_i
  rescue NoMethodError
    0
  end

  def self.take_step(paths, grid)
    new_paths = []
    finished_paths = []
    current_min = paths.map { |path| path[:sum] }.min

    paths.each do |path|
      last_step = path[:steps].last
      next_coord = next_coord(last_step)
      valid_space = valid_space(next_coord, grid)

      next unless valid_space.positive? #new_paths << path.merge(status: 1) unless valid_space.positive?

      DIRECTION_MAPS[last_step[:direction]].each do |new_direction|
        new_step = { coord: next_coord, direction: new_direction }
        straight_count = new_direction == last_step[:direction] ? path[:straight_count] + 1 : path[:straight_count]
        already_passed = path[:steps].any? { |step| step[:coord] == next_coord }
        at_finish = next_coord == [grid[0].length - 1, grid.length - 1]
        new_sum = path[:sum] + valid_space

        next if straight_count > 3 #new_paths << path.merge(status: 1) if straight_count > 3
        next if already_passed #new_paths << path.merge(status: 1) if already_passed
        # next if new_sum > current_min + 18
        next if path[:steps].length > 28

        new_path = path.merge(straight_count: straight_count, steps: path[:steps] + [new_step], sum: new_sum)

        if at_finish
          finished_paths << new_path
        else
          new_paths << new_path
        end
      end
    end

    [new_paths, finished_paths]
  end

  def self.take_greedy_step(paths, grid)
    paths.map do |path|
      last_step = path[:steps].last
      next_coord = next_coord(last_step)
      valid_space = valid_space(next_coord, grid)

      next path.merge(status: 1) unless valid_space.positive?

      new_paths = DIRECTION_MAPS[last_step[:direction]].map do |new_direction|
        new_step = { coord: next_coord, direction: new_direction }
        straight_count = new_direction == last_step[:direction] ? path[:straight_count] + 1 : path[:straight_count]
        already_passed = path[:steps].any? { |step| step[:coord] == next_coord }
        at_finish = next_coord == [grid[0].length - 1, grid.length - 1]
        new_sum = path[:sum] + valid_space

        next if straight_count > 3
        next if already_passed

        new_path = path.merge(straight_count: straight_count, steps: path[:steps] + [new_step], sum: new_sum)

        return new_path.merge(status: 1) if at_finish

        new_path
      end

      new_paths.reject(&:nil?).min_by { |p| p[:sum] }
    end
  end

  def self.part1(grid = INPUT.map { |row| row.strip.chars })
    paths = [
      { straight_count: 1, steps: [{ coord: [0, 0], direction: EAST }], status: 0, sum: 0 },
      { straight_count: 1, steps: [{ coord: [0, 0], direction: SOUTH }], status: 0, sum: 0 },
    ]

    until paths.all? { |p| p[:status] == 1 }
      paths = take_greedy_step(paths, grid)
    end

    paths.map { |p| p[:sum] }.min
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
