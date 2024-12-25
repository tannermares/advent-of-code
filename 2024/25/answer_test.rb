#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 25
class TestDay25 < Test::Unit::TestCase
  def test_part1
    Day25::SAMPLE ? assert_equal(3, Day25.part1) : assert_equal(2_691, Day25.part1)
  end

  def test_part2
    omit
    Day25::SAMPLE ? assert_equal(nil, Day25.part2) : assert_equal(nil, Day25.part2)
  end
end
