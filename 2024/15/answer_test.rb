#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 15
class TestDay15 < Test::Unit::TestCase
  def test_part1
    Day15::SAMPLE ? assert_equal(10_092, Day15.part1) : assert_equal(1_457_740, Day15.part1)
  end

  def test_part2
    Day15::SAMPLE ? assert_equal(9_021, Day15.part2) : assert_equal(1_467_145, Day15.part2)
  end
end
