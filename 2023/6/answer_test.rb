#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 6
class TestDay6 < Test::Unit::TestCase
  def test_part1
    Day6::SAMPLE ? assert_equal(288, Day6.part1) : assert_equal(800_280, Day6.part1)
  end

  def test_part2
    Day6::SAMPLE ? assert_equal(71_503, Day6.part2) : assert_equal(45_128_024, Day6.part2)
  end
end
