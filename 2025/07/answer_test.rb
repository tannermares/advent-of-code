#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 07
class TestDay07 < Test::Unit::TestCase
  def test_part1
    Day07::SAMPLE ? assert_equal(21, Day07.part1) : assert_equal(1_581, Day07.part1)
  end

  def test_part2
    Day07::SAMPLE ? assert_equal(40, Day07.part2) : assert_equal(73_007_003_089_792, Day07.part2)
  end
end
