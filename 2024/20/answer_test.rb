#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 20
class TestDay20 < Test::Unit::TestCase
  def test_part1
    Day20::SAMPLE ? assert_equal(44, Day20.part1) : assert_equal(1_317, Day20.part1)
  end

  def test_part2
    omit
    Day20::SAMPLE ? assert_equal(nil, Day20.part2) : assert_equal(nil, Day20.part2)
  end
end
