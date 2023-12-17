#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 15
class TestDay15 < Test::Unit::TestCase
  def test_hash_sequence
    assert_equal(52, Day15.hash_sequence('HASH'))
  end

  def test_part1
    Day15::SAMPLE ? assert_equal(1_320, Day15.part1) : assert_equal(507_666, Day15.part1)
  end

  def test_part2
    omit
    Day15::SAMPLE ? assert_equal(nil, Day15.part2) : assert_equal(nil, Day15.part2)
  end
end
