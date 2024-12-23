#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 23
class TestDay23 < Test::Unit::TestCase
  def test_part1
    Day23::SAMPLE ? assert_equal(7, Day23.part1) : assert_equal(1_184, Day23.part1)
  end

  # bb,be,cl,dl,el,fm,hq,ht,nf,pw,rr,tv,zx NOT RIGHT
  def test_part2
    omit
    Day23::SAMPLE ? assert_equal('co,de,ka,ta', Day23.part2) : assert_equal(nil, Day23.part2)
  end
end
