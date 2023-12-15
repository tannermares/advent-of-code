#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

GALAXY = [
  ['.', '.', '.', '#', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '#', '.', '.'],
  ['#', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '#', '.', '.', '.'],
  ['.', '#', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '#'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '#', '.', '.'],
  ['#', '.', '.', '.', '#', '.', '.', '.', '.', '.']
].freeze

EXPANDED_GALAXY = [
  ['.', '.', '.', '.', '#', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '#', '.', '.', '.'],
  ['#', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '#', '.', '.', '.', '.'],
  ['.', '#', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '#'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.', '.', '#', '.', '.', '.'],
  ['#', '.', '.', '.', '.', '#', '.', '.', '.', '.', '.', '.', '.']
].freeze

# Test Day 11
class TestDay11 < Test::Unit::TestCase
  # def test_expand_rows
  #   assert_equal([['.', '.', '.', '.'], ['.', '.', '.', '.']], Day11.expand_rows([['.', '.', '.', '.']]))
  #   assert_equal(
  #     [['.', '.', '.', '.'], ['.', '.', '.', '.'], ['.', '.', '.', '.']],
  #     Day11.expand_rows([['.', '.', '.', '.']], 3)
  #   )
  #   assert_equal([['.', '.', '#', '.']], Day11.expand_rows([['.', '.', '#', '.']]))
  #   assert_equal(
  #     [['.', '.', '#', '.'], ['.', '.', '.', '.'], ['.', '.', '.', '.']],
  #     Day11.expand_rows([['.', '.', '#', '.'], ['.', '.', '.', '.']])
  #   )
  # end

  # def test_expand_columns
  #   assert_equal([['.', '.'], ['.', '.'], ['.', '.'], ['.', '.']], Day11.expand_columns([['.'], ['.'], ['.'], ['.']]))
  #   assert_equal(
  #     [['.', '.', '.'], ['.', '.', '.'], ['.', '.', '.'], ['.', '.', '.']],
  #     Day11.expand_columns([['.'], ['.'], ['.'], ['.']], 3)
  #   )
  #   assert_equal([['.'], ['#'], ['.'], ['.']], Day11.expand_columns([['.'], ['#'], ['.'], ['.']]))
  #   assert_equal(
  #     [['.', '.', '.'], ['#', '.', '.'], ['.', '.', '.'], ['.', '.', '.']],
  #     Day11.expand_columns([['.', '.'], ['#', '.'], ['.', '.'], ['.', '.']])
  #   )
  # end

  # def test_expand_galaxy
  #   assert_equal(EXPANDED_GALAXY, Day11.expand_galaxy(GALAXY))
  # end

  # def test_grid_distance
  #   assert_equal(9, Day11.grid_distance([6, 1], [11, 5]))
  #   assert_equal(15, Day11.grid_distance([0, 4], [10, 9]))
  #   assert_equal(17, Day11.grid_distance([2, 0], [7, 12]))
  #   assert_equal(5, Day11.grid_distance([11, 0], [11, 5]))
  #   assert_equal(6, Day11.grid_distance([7, 12], [10, 9]))
  # end

  # def test_part1
  #   Day11::SAMPLE ? assert_equal(374, Day11.part1) : assert_equal(9_605_127, Day11.part1)
  # end

  def test_part2
    # Day11::SAMPLE ? assert_equal(1_030, Day11.part2(10)) : assert_equal(13_270_591, Day11.part2(10))
    # Day11::SAMPLE ? assert_equal(8_410, Day11.part2(100)) : assert_equal(54_507_061, Day11.part2(100))
    # Day11::SAMPLE ? assert_equal(82_210, Day11.part2(1_000)) : assert_equal(466_871_761, Day11.part2(1_000))
    # Day11::SAMPLE ? assert_equal(164_210, Day11.part2(2_000)) : assert_equal(925_054_761, Day11.part2(2_000))
    # Day11::SAMPLE ? assert_equal(410_210, Day11.part2(5_000)) : assert_equal(2_299_603_761, Day11.part2(5_000))
    # Day11::SAMPLE ? assert_equal(820_210, Day11.part2(10_000)) : assert_equal(nil, Day11.part2(10_000))
  end
end

# Real Input 5_000
# Started
# Expanding rows:          0.0   seconds
# Expanding columns:       15.34 seconds
# Joining Galaxy:          63.15 seconds
# Finding Coords Regex:    2.25  seconds
# Summing:                 9.53  seconds
# .
# Finished in 90.300565 seconds.

# Sample 10_000
# Started
# Expanding rows:          0.0   seconds
# Expanding columns:       7.87  seconds
# Joining Galaxy:          35.59 seconds
# Finding Coords Regex:    1.63  seconds
# Summing:                 0.0   seconds
# .
# Finished in 45.094227 seconds.
