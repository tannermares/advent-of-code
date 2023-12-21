#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 21
class TestDay21 < Test::Unit::TestCase
  def test_part1
    Day21::SAMPLE ? assert_equal(16, Day21.part1) : assert_equal(3_731, Day21.part1)
  end

  def test_part2
    omit
    Day21::SAMPLE ? assert_equal(1_594, Day21.part2) : assert_equal(nil, Day21.part2)
  end
end
