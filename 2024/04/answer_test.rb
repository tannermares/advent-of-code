#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 04
class TestDay04 < Test::Unit::TestCase
  def test_part1
    Day04::SAMPLE ? assert_equal(18, Day04.part1) : assert_equal(2_447, Day04.part1)
  end

  def test_part2
    Day04::SAMPLE ? assert_equal(9, Day04.part2) : assert_equal(1868, Day04.part2)
  end
end
