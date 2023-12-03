#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

class TestDay2 < Test::Unit::TestCase
  def test_part1
    assert_equal(532331, part1)
  end

  # def test_part2
  #   assert_equal(nil, part2)
  # end
end
