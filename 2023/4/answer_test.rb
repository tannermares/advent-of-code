#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 4
class TestDay4 < Test::Unit::TestCase
  def test_part1
    Day4::SAMPLE ? assert_equal(13, Day4.part1) : assert_equal(26_426, Day4.part1)
  end

  def test_part2
    Day4::SAMPLE ? assert_equal(30, Day4.part2) : assert_equal(6_227_972, Day4.part2)
  end
end
