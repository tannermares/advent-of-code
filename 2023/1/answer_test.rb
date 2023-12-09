#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay1 < Test::Unit::TestCase
  def test_part1
    Input::SAMPLE ? assert_equal(209, part1) : assert_equal(53_334, part1)
  end

  def test_part2
    Input::SAMPLE ? assert_equal(281, part2) : assert_equal(52_834, part2)
  end
end
