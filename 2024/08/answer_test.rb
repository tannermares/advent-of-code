#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 08
class TestDay08 < Test::Unit::TestCase
  def test_part1
    Day08::SAMPLE ? assert_equal(14, Day08.part1) : assert_equal(348, Day08.part1)
  end

  def test_part2
    Day08::SAMPLE ? assert_equal(34, Day08.part2) : assert_equal(1_221, Day08.part2)
  end
end
