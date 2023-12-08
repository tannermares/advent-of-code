#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay3 < Test::Unit::TestCase
  def test_type_hand
    assert_equal(6, type_hand('AAAAA'))
    assert_equal(5, type_hand('AAAAB'))
    assert_equal(5, type_hand('ABBBB'))
    assert_equal(4, type_hand('AAABB'))
    assert_equal(4, type_hand('AABBB'))
    assert_equal(3, type_hand('AAABC'))
    assert_equal(3, type_hand('ABCCC'))
    assert_equal(3, type_hand('ABBBC'))
    assert_equal(2, type_hand('AABBC'))
    assert_equal(2, type_hand('ABBCC'))
    assert_equal(2, type_hand('AABCC'))
    assert_equal(1, type_hand('AABCD'))
    assert_equal(1, type_hand('ABBCD'))
    assert_equal(1, type_hand('ABCCD'))
    assert_equal(1, type_hand('ABCDD'))
    assert_equal(0, type_hand('ABCDE'))
  end

  def test_part1
    assert_equal(250_898_830, part1)
  end

  def test_part2
    assert_equal(5905, part2)
  end
end
