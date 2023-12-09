#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay9 < Test::Unit::TestCase
  def test_part1
    SAMPLE ? assert_equal(114, part1) : assert_equal(2_043_677_056, part1)
  end

  def test_part2
    SAMPLE ? assert_equal(2, part2) : assert_equal(0, part2)
  end
end
