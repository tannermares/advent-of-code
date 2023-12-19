#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require 'stringio'
require_relative 'answer'

# Test Day 16
class TestDay16 < Test::Unit::TestCase
  # GRID = [
  #   ['.', '|', '.', '.', '.', '\\', '.', '.', '.', '.'],
  #   ['|', '.', '-', '.', '\\', '.', '.', '.', '.', '.'],
  #   ['.', '.', '.', '.', '.', '|', '-', '.', '.', '.'],
  #   ['.', '.', '.', '.', '.', '.', '.', '.', '|', '.'],
  #   ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.'],
  #   ['.', '.', '.', '.', '.', '.', '.', '.', '.', '\\'],
  #   ['.', '.', '.', '.', '/', '.', '\\', '\\', '.', '.'],
  #   ['.', '-', '.', '-', '/', '.', '.', '|', '.', '.'],
  #   ['.', '|', '.', '.', '.', '.', '-', '|', '.', '\\'],
  #   ['.', '.', '/', '/', '.', '|', '.', '.', '.', '.']
  # ].freeze

  # def test_count_uniq_paths
  #   assert_equal(
  #     2,
  #     Day16.count_uniq_paths(
  #       [
  #         { steps: [{ coord: [1, 0], direction: Day16::EAST, space: '.' }], status: 1 },
  #         { steps: [{ coord: [1, 1], direction: Day16::EAST, space: '.' }], status: 1 },
  #         { steps: [{ coord: [1, 0], direction: Day16::EAST, space: '.' }], status: 1 }
  #       ]
  #     )
  #   )
  # end

  # def test_take_step
  #   assert_equal(
  #     [
  #       {
  #         steps: [
  #           { coord: [0, 0], direction: Day16::EAST, space: '.' },
  #           { coord: [1, 0], direction: Day16::NORTH, space: '|' }
  #         ],
  #         status: 0
  #       },
  #       { steps: [{ coord: [1, 0], direction: Day16::SOUTH, space: '|' }], status: 0 }
  #     ],
  #     Day16.take_step([{ steps: [{ coord: [0, 0], direction: Day16::EAST, space: '.' }], status: 0 }], GRID)
  #   )
  #   assert_equal(
  #     [
  #       {
  #         steps: [
  #           { coord: [0, 0], direction: Day16::EAST, space: '.' },
  #           { coord: [1, 0], direction: Day16::NORTH, space: '|' }
  #         ],
  #         status: 1
  #       },
  #       {
  #         steps: [
  #           { coord: [1, 0], direction: Day16::SOUTH, space: '|' },
  #           { coord: [1, 1], direction: Day16::SOUTH, space: '.' }
  #         ],
  #         status: 0
  #       }
  #     ],
  #     Day16.take_step(
  #       [
  #         {
  #           steps: [
  #             { coord: [0, 0], direction: Day16::EAST, space: '.' },
  #             { coord: [1, 0], direction: Day16::NORTH, space: '|' }
  #           ],
  #           status: 0
  #         },
  #         { steps: [{ coord: [1, 0], direction: Day16::SOUTH, space: '|' }], status: 0 }
  #       ],
  #       GRID
  #     )
  #   )
  # end

  # 7720 too low
  def test_part1
    Day16::SAMPLE ? assert_equal(46, Day16.part1) : assert_equal(nil, Day16.part1)
  end

  def test_part2
    omit
    Day16::SAMPLE ? assert_equal(nil, Day16.part2) : assert_equal(nil, Day16.part2)
  end
end
