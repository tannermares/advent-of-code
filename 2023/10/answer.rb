#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 10
module Day10
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  # VALID_MOVES = {
  #   '|' => [['.', %w[7 F], '.'], ['.',     '.',     '.'], ['.', %w[L J], '.']],
  #   '-' => [['.',   '.',   '.'], [%w[L F], '.', %w[J 7]], ['.',   '.',   '.']],
  #   'L' => [['.',   '|',   '.'], ['.',     '.',     '-'], ['.',   '.',   '.']],
  #   'J' => [['.',   '|',   '.'], ['-',     '.',     '.'], ['.',   '.',   '.']],
  #   'F' => [['.',   '.',   '.'], ['.',     '.',     '-'], ['.',   '|',   '.']],
  #   '7' => [['.',   '.',   '.'], ['-',     '.',     '.'], ['.',   '|',   '.']]
  # }.freeze

  def self.type_start(position, map)
    north = position[0].zero? ? nil : map[position[0] - 1][position[1]]
    south = position[0] + 1 == map.length ? nil : map[position[0] + 1][position[1]]
    east = position[1] + 1 == map[0].length ? nil : map[position[0]][position[1] + 1]
    west = position[1].zero? ? nil : map[position[0]][position[1] - 1]

    if %w[| 7 F].include?(north) && %w[| L J].include?(south)
      '|'
    elsif %w[- J 7].include?(east) && %w[- L F].include?(west)
      '-'
    elsif %w[| 7 F].include?(north) && %w[- J 7].include?(east)
      'L'
    elsif %w[| 7 F].include?(north) && %w[- L F].include?(west)
      'J'
    elsif %w[| J L].include?(south) && %w[- J 7].include?(east)
      'F'
    elsif %w[| J L].include?(south) && %w[- L F].include?(west)
      '7'
    else
      raise 'NO VALID TYPE'
    end
  end

  def self.valid_moves_for(tile, position)
    valid_moves = {
      '|' => [[position[0] - 1, position[1]], [position[0] + 1, position[1]]],
      '-' => [[position[0], position[1] - 1], [position[0], position[1] + 1]],
      'L' => [[position[0] - 1, position[1]], [position[0], position[1] + 1]],
      'J' => [[position[0] - 1, position[1]], [position[0], position[1] - 1]],
      'F' => [[position[0] + 1, position[1]], [position[0], position[1] + 1]],
      '7' => [[position[0] + 1, position[1]], [position[0], position[1] - 1]]
    }

    valid_moves[tile]
  end

  def self.part1
    start = [0, 0]
    visited = []

    map = INPUT.map.with_index do |row, index|
      s_position = row.index('S')
      start = [index, s_position] if s_position
      row.strip.split('')
    end
    visited << start

    current_positions = valid_moves_for(type_start(start, map), start)
    steps = 1
    visited.concat(current_positions)

    # puts "visited: #{visited.inspect}"
    # puts "current positions: #{current_positions.inspect}"

    until current_positions.uniq.length == 1
      current_positions = current_positions.flat_map do |cp|
        next_moves = valid_moves_for(map[cp[0]][cp[1]], cp).reject { |m| visited.include?(m) }
        # puts '-' * 50
        # puts "tile: #{map[cp[0]][cp[1]]}"
        # puts "cp: #{cp}"
        # puts "next: #{next_moves}"

        visited.concat(next_moves)
        # puts "visited concat: #{visited.inspect}"
        # puts '-' * 50
        next_moves
      end
      steps += 1
      # puts "current positions: #{current_positions}"
    end
    # puts "visited: #{visited.inspect}"
    # puts "steps: #{steps}"

    steps
  end

  def self.part2
  end
end
