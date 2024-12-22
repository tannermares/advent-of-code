#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 21
module Day21
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  DIRECTION_KEYPAD = {
    ['^', '^'] => 'A',
    ['^', 'A'] => '>A',
    ['^', 'v'] => 'vA',
    ['^', '<'] => 'v<A',
    ['^', '>'] => 'v>A',
    ['A', 'A'] => 'A',
    ['A', '^'] => '<A',
    ['A', '>'] => 'vA',
    ['A', 'v'] => '<vA',
    ['A', '<'] => 'v<<A',
    ['<', '<'] => 'A',
    ['<', 'v'] => '>A',
    ['<', '^'] => '>^A',
    ['<', '>'] => '>>A',
    ['<', 'A'] => '>>^A',
    ['v', 'v'] => 'A',
    ['v', '<'] => '<A',
    ['v', '^'] => '^A',
    ['v', '>'] => '>A',
    ['v', 'A'] => '>^A',
    ['>', '>'] => 'A',
    ['>', 'A'] => '^A',
    ['>', 'v'] => '<A',
    ['>', '^'] => '<^A',
    ['>', '<'] => '<<A'
  }.freeze
  NUMERIC_KEYPAD = {
    ['A', 'A'] => 'A',
    ['A', '0'] => '<A',
    ['A', '1'] => '^<<A',
    ['A', '2'] => '^<A',
    ['A', '3'] => '^A',
    ['A', '4'] => '^^<<A',
    ['A', '5'] => '<^^A',
    ['A', '6'] => '^^A',
    ['A', '7'] => '^^^<<A',
    ['A', '8'] => '^^^<A',
    ['A', '9'] => '^^^A',
    ['0', '0'] => 'A',
    ['0', 'A'] => '>A',
    ['0', '1'] => '^<A',
    ['0', '2'] => '^A',
    ['0', '3'] => '^>A',
    ['0', '4'] => '^^<A',
    ['0', '5'] => '^^A',
    ['0', '6'] => '^^>A',
    ['0', '7'] => '^^^<A',
    ['0', '8'] => '^^^A',
    ['0', '9'] => '^^^>A',
    ['1', '1'] => 'A',
    ['1', 'A'] => '>>vA',
    ['1', '0'] => '>vA',
    ['1', '2'] => '>A',
    ['1', '3'] => '>>A',
    ['1', '4'] => '^A',
    ['1', '5'] => '^>A',
    ['1', '6'] => '^>>A',
    ['1', '7'] => '^^A',
    ['1', '8'] => '^^>A',
    ['1', '9'] => '^^>>A',
    ['2', '2'] => 'A',
    ['2', 'A'] => 'v>A',
    ['2', '0'] => 'vA',
    ['2', '1'] => '<A',
    ['2', '3'] => '>A',
    ['2', '4'] => '^<A',
    ['2', '5'] => '^A',
    ['2', '6'] => '^>A',
    ['2', '7'] => '^^<A',
    ['2', '8'] => '^^A',
    ['2', '9'] => '^^>A',
    ['3', '3'] => 'A',
    ['3', 'A'] => 'vA',
    ['3', '0'] => 'v<A',
    ['3', '1'] => '<<A',
    ['3', '2'] => '<A',
    ['3', '4'] => '^<<A',
    ['3', '5'] => '^<A',
    ['3', '6'] => '^A',
    ['3', '7'] => '<<^^A',
    ['3', '8'] => '^^<A',
    ['3', '9'] => '^^A',
    ['4', '4'] => 'A',
    ['4', 'A'] => '>>vvA',
    ['4', '0'] => '>vvA',
    ['4', '1'] => 'vA',
    ['4', '2'] => 'v>A',
    ['4', '3'] => 'v>>A',
    ['4', '5'] => '>A',
    ['4', '6'] => '>>A',
    ['4', '7'] => '^A',
    ['4', '8'] => '^>A',
    ['4', '9'] => '^>>A',
    ['5', '5'] => 'A',
    ['5', 'A'] => 'vv>A',
    ['5', '0'] => 'vvA',
    ['5', '1'] => 'v<A',
    ['5', '2'] => 'vA',
    ['5', '3'] => 'v>A',
    ['5', '4'] => '<A',
    ['5', '6'] => '>A',
    ['5', '7'] => '^<A',
    ['5', '8'] => '^A',
    ['5', '9'] => '^>A',
    ['6', '6'] => 'A',
    ['6', 'A'] => 'vvA',
    ['6', '0'] => 'vv<A',
    ['6', '1'] => 'v<<A',
    ['6', '2'] => 'v<A',
    ['6', '3'] => 'vA',
    ['6', '4'] => '<<A',
    ['6', '5'] => '<A',
    ['6', '7'] => '<<^A',
    ['6', '8'] => '^<A',
    ['6', '9'] => '^A',
    ['7', '7'] => 'A',
    ['7', 'A'] => '>>vvvA',
    ['7', '0'] => '>vvvA',
    ['7', '1'] => 'vvA',
    ['7', '2'] => 'vv>A',
    ['7', '3'] => 'vv>>A',
    ['7', '4'] => 'vA',
    ['7', '5'] => 'v>A',
    ['7', '6'] => 'v>>A',
    ['7', '8'] => '>A',
    ['7', '9'] => '>>A',
    ['8', '8'] => 'A',
    ['8', 'A'] => 'vvv>A',
    ['8', '0'] => 'vvvA',
    ['8', '1'] => 'vv>A',
    ['8', '2'] => 'vvA',
    ['8', '3'] => 'vv>A',
    ['8', '4'] => 'v<A',
    ['8', '5'] => 'vA',
    ['8', '6'] => 'v>A',
    ['8', '7'] => '<A',
    ['8', '9'] => '>A',
    ['9', '9'] => 'A',
    ['9', 'A'] => 'vvvA',
    ['9', '0'] => 'vvv<A',
    ['9', '1'] => 'vv<<A',
    ['9', '2'] => 'vv<A',
    ['9', '3'] => 'vvA',
    ['9', '4'] => 'v<<A',
    ['9', '5'] => 'v<A',
    ['9', '6'] => 'vA',
    ['9', '7'] => '<<A',
    ['9', '8'] => '<A'
  }.freeze
  INITIAL_KEY = 'A'

  def self.part1
    INPUT.sum do |row|
      keys = row.strip.chars
      first_robot = numeric_keypad(keys)
      second_robot = direction_keypad(first_robot)
      third_robot = direction_keypad(second_robot)
      third_robot.length * keys.join.to_i
    end
  end

  def self.part2
    directional_robots = 25

    INPUT.sum do |row|
      keys = row.strip.chars
      key_presses = numeric_keypad(keys)
      directional_robots.times do
        key_presses = direction_keypad(key_presses)
      end
      key_presses.length * keys.join.to_i
    end
  end

  def self.direction_keypad(input)
    input.map.with_index do |key, index|
      prev_key = index.zero? ? 'A' : input[index - 1]
      DIRECTION_KEYPAD[[prev_key, key]]
    end.join.chars
  end

  def self.numeric_keypad(input)
    input.map.with_index do |key, index|
      prev_key = index.zero? ? 'A' : input[index - 1]
      NUMERIC_KEYPAD[[prev_key, key]]
    end.join.chars
  end
end
