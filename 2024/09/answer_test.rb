#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 09
class TestDay09 < Test::Unit::TestCase
  def test_part1
    Day09::SAMPLE ? assert_equal(1_928, Day09.part1) : assert_equal(6_242_766_523_059, Day09.part1)
  end

  # 8_427_253_745_791 too high
  def test_part2
    Day09::SAMPLE ? assert_equal(2_858, Day09.part2) : assert_equal(nil, Day09.part2)
  end
end
