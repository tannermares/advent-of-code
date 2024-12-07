#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 06
class TestDay06 < Test::Unit::TestCase
  def test_part1
    Day06::SAMPLE ? assert_equal(41, Day06.part1) : assert_equal(5_404, Day06.part1)
  end

  # 5520 too high
  # 2197
  # 2195 too high??
  # 2191
  # 2183 ??
  # 2180 too low
  def test_part2
    Day06::SAMPLE ? assert_equal(6, Day06.part2) : assert_equal(1_984, Day06.part2) #assert_operator(2_180, :<, Day06.part2) && assert_operator(5_520, :>, Day06.part2)
  end
end
