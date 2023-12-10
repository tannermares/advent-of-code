#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 8
class TestDay8 < Test::Unit::TestCase
  def test_part1
    Day8::SAMPLE ? assert_equal(2, Day8.part1) : assert_equal(13_301, Day8.part1)
  end

  def test_part2
    Day8::SAMPLE ? assert_equal(6, Day8.part2) : assert_equal(7_309_459_565_207, Day8.part2)
  end
end
