#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay3 < Test::Unit::TestCase
  def test_part1
    assert_equal(510_109_797, part1)
  end

  def test_part2
    assert_equal(9_622_622, part2)
  end
end
