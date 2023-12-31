#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 7
class TestDay7 < Test::Unit::TestCase
  def test_type_hand
    # Day7.Five of a kind
    assert_equal(6, Day7.type_hand('AAAAA'))

    # Four of a kind
    assert_equal(5, Day7.type_hand('AAAAB'))
    assert_equal(5, Day7.type_hand('ABBBB'))

    # Full House
    assert_equal(4, Day7.type_hand('AAABB'))
    assert_equal(4, Day7.type_hand('AABBB'))

    # Three of a kind
    assert_equal(3, Day7.type_hand('AAABC'))
    assert_equal(3, Day7.type_hand('ABCCC'))
    assert_equal(3, Day7.type_hand('ABBBC'))

    # Two Pair
    assert_equal(2, Day7.type_hand('AABBC'))
    assert_equal(2, Day7.type_hand('ABBCC'))
    assert_equal(2, Day7.type_hand('AABCC'))

    # One Pair
    assert_equal(1, Day7.type_hand('AABCD'))
    assert_equal(1, Day7.type_hand('ABBCD'))
    assert_equal(1, Day7.type_hand('ABCCD'))
    assert_equal(1, Day7.type_hand('ABCDD'))

    # High Card
    assert_equal(0, Day7.type_hand('ABCDE'))
  end

  def test_type_hand_with_jokers
    # Day7.Five of a kind
    assert_equal(6, Day7.type_hand_with_jokers('AAAAJ'))
    assert_equal(6, Day7.type_hand_with_jokers('AAAJJ'))
    assert_equal(6, Day7.type_hand_with_jokers('AAJJJ'))
    assert_equal(6, Day7.type_hand_with_jokers('AJJJJ'))
    assert_equal(6, Day7.type_hand_with_jokers('JJJJJ'))

    # Four of a kind
    assert_equal(5, Day7.type_hand_with_jokers('AAABJ'))
    assert_equal(5, Day7.type_hand_with_jokers('ABBBJ'))
    assert_equal(5, Day7.type_hand_with_jokers('AABJJ'))
    assert_equal(5, Day7.type_hand_with_jokers('ABBJJ'))
    assert_equal(5, Day7.type_hand_with_jokers('ABJJJ'))

    # Full house
    assert_equal(4, Day7.type_hand_with_jokers('AABBJ'))

    # Three of a kind
    assert_equal(3, Day7.type_hand_with_jokers('AABCJ'))
    assert_equal(3, Day7.type_hand_with_jokers('ABCCJ'))
    assert_equal(3, Day7.type_hand_with_jokers('ABBCJ'))
    assert_equal(3, Day7.type_hand_with_jokers('ABCJJ'))

    # Two Pair
    # Not possible with a joker

    # One Pair
    assert_equal(1, Day7.type_hand_with_jokers('ABCDJ'))

    # High Card
    # Not possible with a joker
  end

  def test_part1
    Day7::SAMPLE ? assert_equal(6_440, Day7.part1) : assert_equal(250_898_830, Day7.part1)
  end

  def test_part2
    Day7::SAMPLE ? assert_equal(5_905, Day7.part2) : assert_equal(252_127_335, Day7.part2)
  end
end
