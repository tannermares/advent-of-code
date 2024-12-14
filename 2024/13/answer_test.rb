#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 13
class TestDay13 < Test::Unit::TestCase
  # 31_351 too low
  # 31_781 too high
  # 32_003
  def test_part1
    Day13::SAMPLE ? assert_equal(480, Day13.part1) : assert_equal(nil, Day13.part1)
  end

  def test_part2
    omit
    Day13::SAMPLE ? assert_equal(nil, Day13.part2) : assert_equal(nil, Day13.part2)
  end
end
