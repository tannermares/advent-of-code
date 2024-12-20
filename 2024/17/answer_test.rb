#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 17
class TestDay17 < Test::Unit::TestCase
  # wrong 137464235
  def test_part1
    omit
    Day17::SAMPLE ? assert_equal('4635635210', Day17.part1) : assert_equal(nil, Day17.part1)
  end

  def test_part2
    omit
    Day17::SAMPLE ? assert_equal(nil, Day17.part2) : assert_equal(nil, Day17.part2)
  end
end
