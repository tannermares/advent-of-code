#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 05
class TestDay05 < Test::Unit::TestCase
  def test_part1
    Day05::SAMPLE ? assert_equal(3, Day05.part1) : assert_equal(770, Day05.part1)
  end

  def test_part2
    Day05::SAMPLE ? assert_equal(14, Day05.part2) : assert_equal(357_674_099_117_260, Day05.part2)
  end
end
