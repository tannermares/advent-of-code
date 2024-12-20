#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 19
class TestDay19 < Test::Unit::TestCase
  def test_part1
    Day19::SAMPLE ? assert_equal(6, Day19.part1) : assert_equal(251, Day19.part1)
  end

  def test_part2
    omit
    Day19::SAMPLE ? assert_equal(16, Day19.part2) : assert_equal(nil, Day19.part2)
  end
end
