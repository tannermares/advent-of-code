#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 06
class TestDay06 < Test::Unit::TestCase
  def test_part1
    Day06::SAMPLE ? assert_equal(4_277_556, Day06.part1) : assert_equal(6_725_216_329_103, Day06.part1)
  end

  def test_part2
    Day06::SAMPLE ? assert_equal(3_263_827, Day06.part2) : assert_equal(10_600_728_112_865, Day06.part2)
  end
end
