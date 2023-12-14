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
  def test_expand_galaxy
    omit
    assert_equal(EXPANDED_GALAXY, Day11.expand_galaxy(GALAXY))
  end

  def test_part1
    omit
    Day11::SAMPLE ? assert_equal(374, Day11.part1) : assert_equal(nil, Day11.part1)
  end

  def test_part2
    omit
    Day11::SAMPLE ? assert_equal(nil, Day11.part2) : assert_equal(nil, Day11.part2)
  end
end
