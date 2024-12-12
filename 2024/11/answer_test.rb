#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 11
class TestDay11 < Test::Unit::TestCase
  def test_part1
    Day11::SAMPLE ? assert_equal(55_312, Day11.part1) : assert_equal(183_620, Day11.part1)
  end

  def test_part2
    Day11::SAMPLE ? assert_equal(65_601_038_650_482, Day11.part2) : assert_equal(220_377_651_399_268, Day11.part2)
  end
end
