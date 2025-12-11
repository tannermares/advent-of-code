#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 11
class TestDay11 < Test::Unit::TestCase
  def test_part1
    Day11::SAMPLE ? assert_equal(5, Day11.part1) : assert_equal(nil, Day11.part1)
  end

  def test_part2
    omit
    Day11::SAMPLE ? assert_equal(nil, Day11.part2) : assert_equal(nil, Day11.part2)
  end
end
