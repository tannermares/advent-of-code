#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 01
class TestDay01 < Test::Unit::TestCase
  def test_part1
    omit
    Day01::SAMPLE ? assert_equal(nil, Day01.part1) : assert_equal(nil, Day01.part1)
  end

  def test_part2
    omit
    Day01::SAMPLE ? assert_equal(nil, Day01.part2) : assert_equal(nil, Day01.part2)
  end
end
