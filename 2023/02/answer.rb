#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 2
module Day2
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  MAX_CUBES = { 'blue' => 14, 'green' => 13, 'red' => 12 }.freeze

  def self.part1
    File.foreach(INPUT_PATH).sum do |row|
      title, game = row.split(':')
      _, game_id = title.split(' ')
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
  end

  def self.part2
    File.foreach(INPUT_PATH).sum do |row|
      _title, game = row.split(':')
      sets = game.split(';')
      game_mins = { 'blue' => 0, 'green' => 0, 'red' => 0 }

      sets.each do |set|
        cubes = set.split(', ')

        cubes.each do |cube|
          pulled, color = cube.split(' ')
          game_mins[color] = pulled.to_i if game_mins[color] <= pulled.to_i
        end
      end

      game_mins.values.reduce(:*)
    end
  end
end
