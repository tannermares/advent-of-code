#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 17
class TestDay17 < Test::Unit::TestCase
  GRID = [
    [2, 4, 1, 3, 4, 3, 2, 3, 1, 1, 3, 2, 3],
    [3, 2, 1, 5, 4, 5, 3, 5, 3, 5, 6, 2, 3],
    [3, 2, 5, 5, 2, 4, 5, 6, 5, 4, 2, 5, 4],
    [3, 4, 4, 6, 5, 8, 5, 8, 4, 5, 4, 5, 2],
    [4, 5, 4, 6, 6, 5, 7, 8, 6, 7, 5, 3, 6],
    [1, 4, 3, 8, 5, 9, 8, 7, 9, 8, 4, 5, 4],
    [4, 4, 5, 7, 8, 7, 6, 9, 8, 7, 7, 6, 6],
    [3, 6, 3, 7, 8, 7, 7, 9, 7, 9, 6, 5, 3],
    [4, 6, 5, 4, 9, 6, 7, 9, 8, 6, 8, 8, 7],
    [4, 5, 6, 4, 6, 7, 9, 9, 8, 6, 4, 5, 3],
    [1, 2, 2, 4, 6, 8, 6, 8, 6, 5, 5, 6, 3],
    [2, 5, 4, 6, 5, 4, 8, 8, 8, 7, 7, 3, 5],
    [4, 3, 2, 2, 6, 7, 4, 6, 5, 5, 5, 3, 3]
  ].freeze

  TINY_GRID = [
    [2, 4, 1],
    [3, 2, 1],
    [3, 2, 5]
  ].freeze

  # def test_take_one_step
  #   paths = [
  #     { straight_count: 1, steps: [{ coord: [0, 0], direction: Day17::EAST }], status: 0, sum: 0 },
  #     { straight_count: 1, steps: [{ coord: [0, 0], direction: Day17::SOUTH }], status: 0, sum: 0 }
  #   ]
  #   assert_equal(
  #     [
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }], straight_count: 2, sum: 4 },
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'N' }], straight_count: 1, sum: 4 },
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }], straight_count: 1, sum: 4 },
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }], straight_count: 2, sum: 3 },
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }], straight_count: 1, sum: 3 },
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'W' }], straight_count: 1, sum: 3 }
  #     ],
  #     Day17.take_step(paths, TINY_GRID)
  #   )
  # end

  # def test_take_two_steps
  #   paths = [
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }], straight_count: 2, sum: 4 },
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'N' }], straight_count: 1, sum: 4 },
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }], straight_count: 1, sum: 4 },
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }], straight_count: 2, sum: 3 },
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }], straight_count: 1, sum: 3 },
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'W' }], straight_count: 1, sum: 3 }
  #   ]
  #   assert_equal(
  #     [
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'E' }, { coord: [2, 0],  direction: 'E' }],  straight_count: 3,  sum: 5 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'E' }, { coord: [2, 0],  direction: 'N' }],  straight_count: 2,  sum: 5 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'E' }, { coord: [2, 0],  direction: 'S' }],  straight_count: 2,  sum: 5 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'S' }, { coord: [1, 1],  direction: 'S' }],  straight_count: 2,  sum: 6 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'S' }, { coord: [1, 1],  direction: 'E' }],  straight_count: 1,  sum: 6 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'S' }, { coord: [1, 1],  direction: 'W' }],  straight_count: 1,  sum: 6 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'S' }, { coord: [0, 2],  direction: 'S' }],  straight_count: 3,  sum: 6 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'S' }, { coord: [0, 2],  direction: 'E' }],  straight_count: 2,  sum: 6 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'S' }, { coord: [0, 2],  direction: 'W' }],  straight_count: 2,  sum: 6 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'E' }, { coord: [1, 1],  direction: 'E' }],  straight_count: 2,  sum: 5 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'E' }, { coord: [1, 1],  direction: 'N' }],  straight_count: 1,  sum: 5 },
  #       { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'E' }, { coord: [1, 1],  direction: 'S' }],  straight_count: 1,  sum: 5 }
  #     ],
  #     Day17.take_step(paths, TINY_GRID)
  #   )
  # end

  # def test_take_three_steps
  #   paths = [
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'E' }, { coord: [2, 0],  direction: 'E' }],  straight_count: 3,  sum: 5 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'E' }, { coord: [2, 0],  direction: 'N' }],  straight_count: 2,  sum: 5 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'E' }, { coord: [2, 0],  direction: 'S' }],  straight_count: 2,  sum: 5 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'S' }, { coord: [1, 1],  direction: 'S' }],  straight_count: 2,  sum: 6 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'S' }, { coord: [1, 1],  direction: 'E' }],  straight_count: 1,  sum: 6 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0],  direction: 'S' }, { coord: [1, 1],  direction: 'W' }],  straight_count: 1,  sum: 6 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'S' }, { coord: [0, 2],  direction: 'S' }],  straight_count: 3,  sum: 6 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'S' }, { coord: [0, 2],  direction: 'E' }],  straight_count: 2,  sum: 6 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'S' }, { coord: [0, 2],  direction: 'W' }],  straight_count: 2,  sum: 6 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'E' }, { coord: [1, 1],  direction: 'E' }],  straight_count: 2,  sum: 5 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'E' }, { coord: [1, 1],  direction: 'N' }],  straight_count: 1,  sum: 5 },
  #     { status: 0,  steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1],  direction: 'E' }, { coord: [1, 1],  direction: 'S' }],  straight_count: 1,  sum: 5 }
  #   ]
  #   assert_equal(
  #     [
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }, { coord: [2, 0], direction: 'S' }, { coord: [2, 1], direction: 'S' }], straight_count: 3,  sum: 6},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }, { coord: [2, 0], direction: 'S' }, { coord: [2, 1], direction: 'E' }], straight_count: 2,  sum: 6},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }, { coord: [2, 0], direction: 'S' }, { coord: [2, 1], direction: 'W' }], straight_count: 2,  sum: 6},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'S' }], straight_count: 3,  sum: 8},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'E' }], straight_count: 2,  sum: 8},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'W' }], straight_count: 2,  sum: 8},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'E' }], straight_count: 2,  sum: 7},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'N' }], straight_count: 1,  sum: 7},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'S' }], straight_count: 1,  sum: 7},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'W' }, { coord: [0, 1], direction: 'W' }], straight_count: 2,  sum: 9},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'W' }, { coord: [0, 1], direction: 'N' }], straight_count: 1,  sum: 9},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'W' }, { coord: [0, 1], direction: 'S' }], straight_count: 1,  sum: 9},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }, { coord: [0, 2], direction: 'E' }, { coord: [1, 2], direction: 'E' }], straight_count: 3,  sum: 8},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }, { coord: [0, 2], direction: 'E' }, { coord: [1, 2], direction: 'N' }], straight_count: 2,  sum: 8},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }, { coord: [0, 2], direction: 'E' }, { coord: [1, 2], direction: 'S' }], straight_count: 2,  sum: 8},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'E' }], straight_count: 3,  sum: 6},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'N' }], straight_count: 2,  sum: 6},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'S' }], straight_count: 2,  sum: 6},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'N' }, { coord: [1, 0], direction: 'N' }], straight_count: 2,  sum: 9},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'N' }, { coord: [1, 0], direction: 'E' }], straight_count: 1,  sum: 9},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'N' }, { coord: [1, 0], direction: 'W' }], straight_count: 1,  sum: 9},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'S' }], straight_count: 2,  sum: 7},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'E' }], straight_count: 1,  sum: 7},
  #       { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'W' }], straight_count: 1,  sum: 7}
  #     ],
  #     Day17.take_step(paths, TINY_GRID)
  #   )
  # end

  # def test_take_four_steps
  #   paths = [
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }, { coord: [2, 0], direction: 'S' }, { coord: [2, 1], direction: 'S' }], straight_count: 3,  sum: 6},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }, { coord: [2, 0], direction: 'S' }, { coord: [2, 1], direction: 'E' }], straight_count: 2,  sum: 6},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'E' }, { coord: [2, 0], direction: 'S' }, { coord: [2, 1], direction: 'W' }], straight_count: 2,  sum: 6},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'S' }], straight_count: 3,  sum: 8},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'E' }], straight_count: 2,  sum: 8},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'W' }], straight_count: 2,  sum: 8},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'E' }], straight_count: 2,  sum: 7},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'N' }], straight_count: 1,  sum: 7},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'S' }], straight_count: 1,  sum: 7},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'W' }, { coord: [0, 1], direction: 'W' }], straight_count: 2,  sum: 9},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'W' }, { coord: [0, 1], direction: 'N' }], straight_count: 1,  sum: 9},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'E' }, { coord: [1, 0], direction: 'S' }, { coord: [1, 1], direction: 'W' }, { coord: [0, 1], direction: 'S' }], straight_count: 1,  sum: 9},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }, { coord: [0, 2], direction: 'E' }, { coord: [1, 2], direction: 'E' }], straight_count: 3,  sum: 8},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }, { coord: [0, 2], direction: 'E' }, { coord: [1, 2], direction: 'N' }], straight_count: 2,  sum: 8},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'S' }, { coord: [0, 2], direction: 'E' }, { coord: [1, 2], direction: 'S' }], straight_count: 2,  sum: 8},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'E' }], straight_count: 3,  sum: 6},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'N' }], straight_count: 2,  sum: 6},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'E' }, { coord: [2, 1], direction: 'S' }], straight_count: 2,  sum: 6},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'N' }, { coord: [1, 0], direction: 'N' }], straight_count: 2,  sum: 9},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'N' }, { coord: [1, 0], direction: 'E' }], straight_count: 1,  sum: 9},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'N' }, { coord: [1, 0], direction: 'W' }], straight_count: 1,  sum: 9},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'S' }], straight_count: 2,  sum: 7},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'E' }], straight_count: 1,  sum: 7},
  #     { status: 0, steps: [{ coord: [0, 0], direction: 'S' }, { coord: [0, 1], direction: 'E' }, { coord: [1, 1], direction: 'S' }, { coord: [1, 2], direction: 'W' }], straight_count: 1,  sum: 7}
  #   ]
  #   assert_equal(
  #     [
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"S"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"S"}], :straight_count=>4, :sum=>11},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"S"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"E"}], :straight_count=>3, :sum=>11},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"S"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"W"}], :straight_count=>3, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"S"}, {:coord=>[2, 1], :direction=>"W"}, {:coord=>[1, 1], :direction=>"W"}], :straight_count=>3, :sum=>8},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"S"}, {:coord=>[2, 1], :direction=>"W"}, {:coord=>[1, 1], :direction=>"N"}], :straight_count=>2, :sum=>8},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"S"}, {:coord=>[2, 1], :direction=>"W"}, {:coord=>[1, 1], :direction=>"S"}], :straight_count=>2, :sum=>8},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"E"}], :straight_count=>3, :sum=>13},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"N"}], :straight_count=>2, :sum=>13},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"S"}], :straight_count=>2, :sum=>13},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"W"}, {:coord=>[0, 2], :direction=>"W"}], :straight_count=>3, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"W"}, {:coord=>[0, 2], :direction=>"N"}], :straight_count=>2, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"W"}, {:coord=>[0, 2], :direction=>"S"}], :straight_count=>2, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"N"}, {:coord=>[2, 0], :direction=>"N"}], :straight_count=>2, :sum=>8},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"N"}, {:coord=>[2, 0], :direction=>"E"}], :straight_count=>1, :sum=>8},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"N"}, {:coord=>[2, 0], :direction=>"W"}], :straight_count=>1, :sum=>8},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"S"}], :straight_count=>2, :sum=>12},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"E"}], :straight_count=>1, :sum=>12},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"W"}], :straight_count=>1, :sum=>12},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"W"}, {:coord=>[0, 1], :direction=>"N"}, {:coord=>[0, 0], :direction=>"N"}], :straight_count=>2, :sum=>11},
  #       {:status=>1, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"W"}, {:coord=>[0, 1], :direction=>"N"}, {:coord=>[0, 0], :direction=>"E"}], :straight_count=>1, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"W"}, {:coord=>[0, 1], :direction=>"N"}, {:coord=>[0, 0], :direction=>"W"}], :straight_count=>1, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"W"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"S"}], :straight_count=>2, :sum=>12},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"W"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"E"}], :straight_count=>1, :sum=>12},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"E"}, {:coord=>[1, 0], :direction=>"S"}, {:coord=>[1, 1], :direction=>"W"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"W"}], :straight_count=>1, :sum=>12},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"E"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"E"}], :straight_count=>4, :sum=>13},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"E"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"N"}], :straight_count=>3, :sum=>13},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"E"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"S"}], :straight_count=>3, :sum=>13},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"E"}, {:coord=>[1, 2], :direction=>"N"}, {:coord=>[1, 1], :direction=>"N"}], :straight_count=>3, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"E"}, {:coord=>[1, 2], :direction=>"N"}, {:coord=>[1, 1], :direction=>"E"}], :straight_count=>2, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"S"}, {:coord=>[0, 2], :direction=>"E"}, {:coord=>[1, 2], :direction=>"N"}, {:coord=>[1, 1], :direction=>"W"}], :straight_count=>2, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"N"}, {:coord=>[2, 0], :direction=>"N"}], :straight_count=>3, :sum=>7},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"N"}, {:coord=>[2, 0], :direction=>"E"}], :straight_count=>2, :sum=>7},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"N"}, {:coord=>[2, 0], :direction=>"W"}], :straight_count=>2, :sum=>7},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"S"}], :straight_count=>3, :sum=>11},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"E"}], :straight_count=>2, :sum=>11},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"E"}, {:coord=>[2, 1], :direction=>"S"}, {:coord=>[2, 2], :direction=>"W"}], :straight_count=>2, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"N"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"E"}], :straight_count=>2, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"N"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"N"}], :straight_count=>1, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"N"}, {:coord=>[1, 0], :direction=>"E"}, {:coord=>[2, 0], :direction=>"S"}], :straight_count=>1, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"N"}, {:coord=>[1, 0], :direction=>"W"}, {:coord=>[0, 0], :direction=>"W"}], :straight_count=>2, :sum=>11},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"N"}, {:coord=>[1, 0], :direction=>"W"}, {:coord=>[0, 0], :direction=>"N"}], :straight_count=>1, :sum=>11},
  #       {:status=>1, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"N"}, {:coord=>[1, 0], :direction=>"W"}, {:coord=>[0, 0], :direction=>"S"}], :straight_count=>1, :sum=>11},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"E"}], :straight_count=>2, :sum=>12},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"N"}], :straight_count=>1, :sum=>12},
  #       {:status=>2, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"E"}, {:coord=>[2, 2], :direction=>"S"}], :straight_count=>1, :sum=>12},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"W"}, {:coord=>[0, 2], :direction=>"W"}], :straight_count=>2, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"W"}, {:coord=>[0, 2], :direction=>"N"}], :straight_count=>1, :sum=>10},
  #       {:status=>0, :steps=>[{:coord=>[0, 0], :direction=>"S"}, {:coord=>[0, 1], :direction=>"E"}, {:coord=>[1, 1], :direction=>"S"}, {:coord=>[1, 2], :direction=>"W"}, {:coord=>[0, 2], :direction=>"S"}], :straight_count=>1, :sum=>10}
  #     ],
  #     Day17.take_step(paths, TINY_GRID)
  #   )
  # end

  def test_part1
    Day17::SAMPLE ? assert_equal(102, Day17.part1) : assert_equal(nil, Day17.part1)
  end

  def test_part2
    omit
    Day17::SAMPLE ? assert_equal(nil, Day17.part2) : assert_equal(nil, Day17.part2)
  end
end
