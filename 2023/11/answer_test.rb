#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 11
class TestDay11 < Test::Unit::TestCase
  def test_grid_distance
    assert_equal(9, Day11.grid_distance([6, 1], [11, 5]))
    assert_equal(15, Day11.grid_distance([0, 4], [10, 9]))
    assert_equal(17, Day11.grid_distance([2, 0], [7, 12]))
    assert_equal(5, Day11.grid_distance([11, 0], [11, 5]))
    assert_equal(6, Day11.grid_distance([7, 12], [10, 9]))
  end

  def test_part1
    Day11::SAMPLE ? assert_equal(374, Day11.part1) : assert_equal(9_605_127, Day11.part1)
  end

  def test_part2
    Day11::SAMPLE ? assert_equal(82_000_210, Day11.part2) : assert_equal(458_191_688_761, Day11.part2)
  end
end
