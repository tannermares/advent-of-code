#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 02
class TestDay02 < Test::Unit::TestCase
  def test_part1
    Day02::SAMPLE ? assert_equal(1_227_775_554, Day02.part1) : assert_equal(53_420_042_388, Day02.part1)
  end

  def test_part2
    Day02::SAMPLE ? assert_equal(4_174_379_265, Day02.part2) : assert_equal(69_553_832_684, Day02.part2)
  end
end
