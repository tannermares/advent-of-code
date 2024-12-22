#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 22
class TestDay22 < Test::Unit::TestCase
  def test_part1
    Day22::SAMPLE ? assert_equal(37_327_623, Day22.part1) : assert_equal(14_476_723_788, Day22.part1)
  end

  def test_part2
    omit
    Day22::SAMPLE ? assert_equal(23, Day22.part2) : assert_equal(nil, Day22.part2)
  end
end
