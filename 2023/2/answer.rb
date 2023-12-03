#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'input.txt').freeze
MAX_CUBES = {
  'blue' => 14,
  'green' => 13,
  'red' => 12
}.freeze

part1 = File.foreach(INPUT_PATH).sum do |row|
  title, game = row.split(':')
  game_id = title.split(' ')[1]
  sets = game.split(';')

  invalid_game = sets.any? do |set|
    cubes = set.split(', ')

    cubes.any? do |cube|
      pulled, color = cube.split(' ')
      pulled.to_i > MAX_CUBES[color]
    end
  end

  invalid_game ? 0 : game_id.to_i
end

part2 = File.foreach(INPUT_PATH).sum do |row|
  _title, game = row.split(':')
  sets = game.split(';')
  current_mins = {
    'blue' => 0,
    'green' => 0,
    'red' => 0
  }

  sets.each do |set|
    cubes = set.split(', ')

    cubes.each do |cube|
      pulled, color = cube.split(' ')
      current_mins[color] = pulled.to_i if current_mins[color] <= pulled.to_i
    end
  end

  current_mins.values.reduce(:*)
end

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
