#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 2
class TestDay2 < Test::Unit::TestCase
  def test_part1
    Day2::SAMPLE ? assert_equal(8, Day2.part1) : assert_equal(1_867, Day2.part1)
  end

  def test_part2
    Day2::SAMPLE ? assert_equal(2_286, Day2.part2) : assert_equal(84_538, Day2.part2)
  end
end
