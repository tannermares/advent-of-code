#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 18
module Day18
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.fill_dig(dig)
    dig.map.with_index do |row, index|
      new_row = row.dup
      edges = row.map.with_index { |n, i| n == '#' ? i : nil }.compact

      gaps = edges.each_with_object([]).with_index do |(n, acc), i|
        acc << [n, edges[i + 1]] if edges[i + 1] && n + 1 < edges[i + 1]
      end

      gaps.each_with_index do |gap, i|
        matches_previous = i.positive? && gaps[i - 1][1] == gap[0]
        matches_next = gaps[i + 1] && gaps[i + 1][0] == gap[1]
        next if matches_previous && matches_next

        (gap[0] + 1..gap[1] - 1).each do |n|
          edges_above = (0..index).any? { |m| dig[m][n] == '#' }
          edges_below = (index..dig.length - 1).any? { |m| dig[m][n] == '#' }

          next unless edges_above && edges_below

          new_row[n] = '#'
        end
      end

      new_row
    end
  end

  def self.dig_with_plan(dig_plan)
    dig = [['#']]
    current_location = [0, 0]

    dig_plan.each do |plan|
      plan[:amount].times do
        current_location =
          case plan[:direction]
          when 'R'
            [current_location[0] + 1, current_location[1]]
          when 'D'
            [current_location[0], current_location[1] + 1]
          when 'U'
            [current_location[0], current_location[1] - 1]
          when 'L'
            [current_location[0] - 1, current_location[1]]
          else
            raise 'WAT'
          end

        if current_location[1].negative?
          current_location[1] = 0
          dig.unshift([])
        else
          dig[current_location[1]] ||= []
        end

        if current_location[0].negative?
          current_location[0] = 0
          dig[current_location[1]].unshift('#')
        else
          dig[current_location[1]][current_location[0]] = '#'
        end
      end
    end

    dig
  end

  def self.part1
    dig_plan = INPUT.map do |row|
      direction, amount, color = row.split(' ')
      amount = amount.to_i
      color = color.gsub(/\(|\)/, '')
      { direction: direction, amount: amount, color: color }
    end
    dig = dig_with_plan(dig_plan)
    filled_dig = fill_dig(dig)
    filled_dig.sum { |row| row.count { |n| n == '#' } }
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
