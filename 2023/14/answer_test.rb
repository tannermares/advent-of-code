#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 14
class TestDay14 < Test::Unit::TestCase
  def test_sort_rocks_to_front
    assert_equal('OOOO....##', Day14.sort_rocks_to_front('OO.O.O..##'))
    assert_equal('OOO.......', Day14.sort_rocks_to_front('...OO....O'))
    assert_equal('O....#OO..', Day14.sort_rocks_to_front('.O...#O..O'))
    assert_equal('....#.....', Day14.sort_rocks_to_front('....#.....'))
  end

  def test_part1
    Day14::SAMPLE ? assert_equal(136, Day14.part1) : assert_equal(nil, Day14.part1)
  end

  def test_part2
    omit
    Day14::SAMPLE ? assert_equal(nil, Day14.part2) : assert_equal(nil, Day14.part2)
  end
end