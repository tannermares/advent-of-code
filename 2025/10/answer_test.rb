#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 10
class TestDay10 < Test::Unit::TestCase
  def test_part1
    Day10::SAMPLE ? assert_equal(7, Day10.part1) : assert_equal(484, Day10.part1)
  end

  def test_part2
    Day10::SAMPLE ? assert_equal(33, Day10.part2) : assert_equal(nil, Day10.part2)
  end
end
