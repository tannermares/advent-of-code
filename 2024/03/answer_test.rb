#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 3
class TestDay3 < Test::Unit::TestCase
  def test_part1
    Day3::SAMPLE ? assert_equal(161, Day3.part1) : assert_equal(182_780_583, Day3.part1)
  end

  def test_part2
    Day3::SAMPLE ? assert_equal(48, Day3.part2) : assert_equal(90_772_405, Day3.part2)
  end
end
