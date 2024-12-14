#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 13
class TestDay13 < Test::Unit::TestCase
  def test_part1
    Day13::SAMPLE ? assert_equal(480, Day13.part1) : assert_equal(31_623, Day13.part1)
  end

  def test_part2
    Day13::SAMPLE ? assert_equal(875_318_608_908, Day13.part2) : assert_equal(93_209_116_744_825, Day13.part2)
  end
end
