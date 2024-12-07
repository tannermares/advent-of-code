#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 07
class TestDay07 < Test::Unit::TestCase
  def test_part1
    Day07::SAMPLE ? assert_equal(3_749, Day07.part1) : assert_equal(882_304_362_421, Day07.part1)
  end

  def test_part2
    Day07::SAMPLE ? assert_equal(11_387, Day07.part2) : assert_equal(145_149_066_755_184, Day07.part2)
  end
end
