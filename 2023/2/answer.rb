#!/usr/bin/env ruby
# frozen_string_literal: true

MAX_CUBES = {
  'blue' => 14,
  'green' => 13,
  'red' => 12
}.freeze
input = File.open(File.join(File.dirname(__FILE__), 'input.txt'))

part1 = input.sum do |row|
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

puts "Part 1 Answer: #{part1}"
