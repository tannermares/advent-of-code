#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay7 < Test::Unit::TestCase
  def test_part1
    SAMPLE ? assert_equal(6, part1) : assert_equal(13_301, part1)
  end

  def test_part2
    SAMPLE ? assert_equal(6, part2) : assert_equal(0, part2)
  end
end
