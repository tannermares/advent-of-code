#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 24
class TestDay24 < Test::Unit::TestCase
  def test_part1
    Day24::SAMPLE ? assert_equal(2024, Day24.part1) : assert_equal(57_344_080_719_736, Day24.part1)
  end

  def test_part2
    omit
    Day24::SAMPLE ? assert_equal('z00,z01,z02,z05', Day24.part2) : assert_equal(nil, Day24.part2)
  end
end
