#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay5 < Test::Unit::TestCase
  def test_part1
    SAMPLE ? assert_equal(35, part1) : assert_equal(510_109_797, part1)
  end

  def test_part2
    SAMPLE ? assert_equal(46, part2) : assert_equal(9_622_622, part2)
  end
end
