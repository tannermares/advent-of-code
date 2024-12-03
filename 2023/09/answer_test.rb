#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 9
class TestDay9 < Test::Unit::TestCase
  def test_part1
    Day9::SAMPLE ? assert_equal(114, Day9.part1) : assert_equal(2_043_677_056, Day9.part1)
  end

  def test_part2
    Day9::SAMPLE ? assert_equal(2, Day9.part2) : assert_equal(1_062, Day9.part2)
  end
end
