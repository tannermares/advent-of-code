#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 16
class TestDay16 < Test::Unit::TestCase
  def test_part1
    Day16::SAMPLE ? assert_equal(11_048, Day16.part1) : assert_equal(101_492, Day16.part1)
  end

  def test_part2
    omit
    Day16::SAMPLE ? assert_equal(64, Day16.part2) : assert_equal(nil, Day16.part2)
  end
end
