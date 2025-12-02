#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 01
module Day01
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    current_position = 50

    INPUT.count do |row|
      new_row = row.dup
      direction = new_row.slice!(0)
      amount = direction == 'R' ? new_row.to_i : -new_row.to_i
      new_position = current_position + amount
      current_position = new_position % 100
      current_position.zero?
    end
  end

  def self.part2
    current_position = 50
    zeros = 0

    INPUT.each do |row|
      new_row = row.dup
      direction = new_row.slice!(0)
      amount = new_row.to_i
      operator = direction == 'R' ? :+ : :-

      amount.times do |_|
        current_position = current_position.send(operator, 1)
        current_position %= 100
        zeros += 1 if current_position.zero?
      end
    end

    zeros
  end
end
