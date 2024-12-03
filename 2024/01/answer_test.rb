#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 1
class TestDay1 < Test::Unit::TestCase
  def test_part1
    Day1::SAMPLE ? assert_equal(11, Day1.part1) : assert_equal(1_765_812, Day1.part1)
  end

  def test_part2
    Day1::SAMPLE ? assert_equal(31, Day1.part2) : assert_equal(20_520_794, Day1.part2)
  end
end
