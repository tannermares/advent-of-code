#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 08
class TestDay08 < Test::Unit::TestCase
  def test_part1
    Day08::SAMPLE ? assert_equal(40, Day08.part1) : assert_equal(96_672, Day08.part1)
  end

  # 176_904
  def test_part2
    Day08::SAMPLE ? assert_equal(25_272, Day08.part2) : assert_equal(nil, Day08.part2)
  end
end
