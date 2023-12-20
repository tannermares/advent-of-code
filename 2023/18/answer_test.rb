#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 18
class TestDay18 < Test::Unit::TestCase
  # 65_578 too high
  # 51_529 wrong
  # 46_862 wrong
  # 44_372 too low
  # 38_746 too low
  # 995 too low
  DIG = [
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', '.', '.', '.', '.', '.', '#'],
    ['#', '#', '.', '.', '.', '.', '#'],
    ['.', '#', '.', '.', '.', '.', '#'],
    ['.', '#', '.', '.', '.', '.', '#'],
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', '.', '#', '.', '#', '#', '.'],
    ['#', '#', '#', '.', '#', '#', '.'],
    ['.', '#', '#', '.', '#', '#', '.'],
    ['.', '#', '#', '.', '#', '#', '.']
  ].freeze

  FILLED_DIG = [
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', '#', '#', '#', '#', '#', '#'],
    ['.', '#', '#', '#', '#', '#', '#'],
    ['.', '#', '#', '#', '#', '#', '#'],
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', '#', '#', '.', '#', '#', '.'],
    ['#', '#', '#', '.', '#', '#', '.'],
    ['.', '#', '#', '.', '#', '#', '.'],
    ['.', '#', '#', '.', '#', '#', '.']
  ].freeze

  def test_fill_dig
    assert_equal(FILLED_DIG, Day18.fill_dig(DIG))
  end

  def test_part1
    omit
    Day18::SAMPLE ? assert_equal(62, Day18.part1) : assert_equal(nil, Day18.part1)
  end

  def test_part2
    omit
    Day18::SAMPLE ? assert_equal(nil, Day18.part2) : assert_equal(nil, Day18.part2)
  end
end
