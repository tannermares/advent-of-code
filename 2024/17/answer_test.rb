#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 17
class TestDay17 < Test::Unit::TestCase
  # wrong 137464235
  def test_part1
    omit
    Day17::SAMPLE ? assert_equal('4,6,3,5,6,3,5,2,1,0', Day17.part1) : assert_equal('1,3,7,4,6,4,2,3,5', Day17.part1)
  end

  def test_part2
    Day17::SAMPLE ? assert_equal(117_440, Day17.part2) : assert_equal(nil, Day17.part2)
  end
end
