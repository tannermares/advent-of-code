#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 14
class TestDay14 < Test::Unit::TestCase
  def test_part1
    Day14::SAMPLE ? assert_equal(12, Day14.part1) : assert_equal(231_221_760, Day14.part1)
  end

  def test_part2
    Day14::SAMPLE ? assert_equal(nil, Day14.part2) : assert_equal(6_771, Day14.part2)
  end
end
