#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay3 < Test::Unit::TestCase
  def test_part1
    assert_equal(532_331, part1)
  end

  def test_part2
    assert_equal(82_301_120, part2)
  end
end