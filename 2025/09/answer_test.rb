#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 09
class TestDay09 < Test::Unit::TestCase
  def test_part1
    Day09::SAMPLE ? assert_equal(50, Day09.part1) : assert_equal(4_733_727_792, Day09.part1)
  end

  def test_part2
    Day09::SAMPLE ? assert_equal(24, Day09.part2) : assert_equal(nil, Day09.part2)
  end
end
