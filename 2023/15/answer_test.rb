#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 15
class TestDay15 < Test::Unit::TestCase
  def test_sum_box
    assert_equal(5, Day15.sum_box(0, [['rn', 1], ['cm', 2]]))
    assert_equal(140, Day15.sum_box(3, [['ot', 7], ['ab', 5], ['pc', 6]]))
  end

  def test_sort_lens
    assert_equal({ 0 => [['rn', 1]] }, Day15.sort_lens({}, 'rn=1'))
    assert_equal({ 0 => [['rn', 1], ['cm', 2]] }, Day15.sort_lens({ 0 => [['rn', 1]] }, 'cm=2'))
    assert_equal({ 0 => [['rn', 1]] }, Day15.sort_lens({ 0 => [['rn', 1]] }, 'cm-'))
    assert_equal({ 0 => [['rn', 1]] }, Day15.sort_lens({ 0 => [['rn', 1], ['cm', 2]] }, 'cm-'))
  end

  def test_hash_sequence
    assert_equal(52, Day15.hash_sequence('HASH'))
  end

  def test_part1
    Day15::SAMPLE ? assert_equal(1_320, Day15.part1) : assert_equal(507_666, Day15.part1)
  end

  def test_part2
    Day15::SAMPLE ? assert_equal(145, Day15.part2) : assert_equal(233_537, Day15.part2)
  end
end
