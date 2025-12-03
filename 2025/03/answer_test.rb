#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 03
class TestDay03 < Test::Unit::TestCase
  def test_part1
    Day03::SAMPLE ? assert_equal(357, Day03.part1) : assert_equal(17_403, Day03.part1)
  end

  def test_part2
    omit
    Day03::SAMPLE ? assert_equal(nil, Day03.part2) : assert_equal(nil, Day03.part2)
  end
end
