#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 12
class TestDay12 < Test::Unit::TestCase
  def test_part1
    Day12::SAMPLE ? assert_equal(1_930, Day12.part1) : assert_equal(1_451_030, Day12.part1)
  end

  def test_part2
    Day12::SAMPLE ? assert_equal(1_206, Day12.part2) : assert_equal(nil, Day12.part2)
  end
end
