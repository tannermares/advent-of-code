#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 19
class TestDay19 < Test::Unit::TestCase
  def test_sum_accepted
    accepted_parts = [
      { x: 787, m: 2655, a: 1222, s: 2876, current_workflow: 'A' },
      { x: 2036, m: 264, a: 79, s: 2244, current_workflow: 'A' },
      { x: 2127, m: 1623, a: 2188, s: 1013, current_workflow: 'A' }
    ]
    assert_equal(19_114, Day19.sum_accepted(accepted_parts))
  end

  def test_parse_parts
    assert_equal({ x: 787, m: 2655, a: 1222, s: 2876, current_workflow: :in }, Day19.parse_parts('{x=787,m=2655,a=1222,s=2876}'))
  end

  def test_part1
    Day19::SAMPLE ? assert_equal(19_114, Day19.part1) : assert_equal(368_964, Day19.part1)
  end

  def test_part2
    omit
    Day19::SAMPLE ? assert_equal(167_409_079_868_000, Day19.part2) : assert_equal(nil, Day19.part2)
  end
end
