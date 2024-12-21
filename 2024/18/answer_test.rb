#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 18
class TestDay18 < Test::Unit::TestCase
  def test_part1
    Day18::SAMPLE ? assert_equal(22, Day18.part1) : assert_equal(280, Day18.part1)
  end

  def test_part2
    Day18::SAMPLE ? assert_equal('6,1', Day18.part2) : assert_equal('28,56', Day18.part2)
  end
end
