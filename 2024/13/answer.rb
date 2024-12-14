#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 13
module Day13
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    machines = []
    current_machine = {}

    INPUT.each do |row|
      if row == "\n"
        machines << current_machine
        current_machine = {}
        next
      end

      button_a = row.scan(/Button A: X\+(\d+), Y\+(\d+)/)[0]
      next current_machine[:a] = button_a.map(&:to_i) if button_a

      button_b = row.scan(/Button B: X\+(\d+), Y\+(\d+)/)[0]
      next current_machine[:b] = button_b.map(&:to_i) if button_b

      prize = row.scan(/Prize: X=(\d+), Y=(\d+)/)[0]
      current_machine[:prize] = prize.map(&:to_i) if prize
    end

    machines.sum do |machine|
      x_num = (machine[:prize][0] * machine[:b][1]) + (machine[:prize][1] * -machine[:b][0])
      x_denom = (machine[:a][0] * machine[:b][1]) + (machine[:a][1] * -machine[:b][0])
      x = x_num / x_denom

      x2_num = (machine[:prize][1] * machine[:b][0]) + (machine[:prize][0] * -machine[:b][1])
      x2_denom = (machine[:a][1] * machine[:b][0]) + (machine[:a][0] * -machine[:b][1])
      x2 = x2_num / x2_denom
      # next 0 unless x == x2

      y_num = machine[:prize][0] - (machine[:a][0] * x)
      y_denom = machine[:b][0]
      y = y_num / y_denom

      y2_num = machine[:prize][1] - (machine[:a][1] * x2)
      y2_denom = machine[:b][1]
      y2 = y2_num / y2_denom
      # next 0 unless y == y2

      proved1 = (machine[:a][0] * x) + (machine[:b][0] * y) == machine[:prize][0]
      proved2 = (machine[:a][1] * x2) + (machine[:b][1] * y2) == machine[:prize][1]
      next 0 unless proved1 && proved2

      (x * 3) + (y * 1)
    end
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
