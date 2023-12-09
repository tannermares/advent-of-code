#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay4 < Test::Unit::TestCase
  def test_part1
    SAMPLE ? assert_equal(13, part1) : assert_equal(26_426, part1)
  end

  def test_part2
    SAMPLE ? assert_equal(30, part2) : assert_equal(6_227_972, part2)
  end
end
