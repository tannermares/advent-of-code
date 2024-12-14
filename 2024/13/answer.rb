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
      next if row == "\n"

      if current_machine[:a].nil?
        button_a = row.scan(/Button A: X\+(\d+), Y\+(\d+)/)[0]
        next current_machine[:a] = button_a.map(&:to_i) if button_a
      end

      if current_machine[:b].nil?
        button_b = row.scan(/Button B: X\+(\d+), Y\+(\d+)/)[0]
        next current_machine[:b] = button_b.map(&:to_i) if button_b
      end

      if current_machine[:prize].nil?
        prize = row.scan(/Prize: X=(\d+), Y=(\d+)/)[0]
        if prize
          current_machine[:prize] = prize.map(&:to_i)
          machines << current_machine
          current_machine = {}
        end
      end
    end

    machines.sum do |machine|
      x_num = (machine[:prize][0] * machine[:b][1]) - (machine[:prize][1] * machine[:b][0])
      x_denom = (machine[:a][0] * machine[:b][1]) - (machine[:a][1] * machine[:b][0])
      x = x_num / x_denom

      y_num = machine[:prize][0] - (machine[:a][0] * x)
      y_denom = machine[:b][0]
      y = y_num / y_denom

      proved = (machine[:a][0] * x) + (machine[:b][0] * y) == machine[:prize][0] &&
               (machine[:a][1] * x) + (machine[:b][1] * y) == machine[:prize][1]

      next 0 unless proved

      (x * 3) + (y * 1)
    end
  end

  def self.part2
    machines = []
    current_machine = {}

    INPUT.each do |row|
      next if row == "\n"

      if current_machine[:a].nil?
        button_a = row.scan(/Button A: X\+(\d+), Y\+(\d+)/)[0]
        next current_machine[:a] = button_a.map(&:to_i) if button_a
      end

      if current_machine[:b].nil?
        button_b = row.scan(/Button B: X\+(\d+), Y\+(\d+)/)[0]
        next current_machine[:b] = button_b.map(&:to_i) if button_b
      end

      if current_machine[:prize].nil?
        prize = row.scan(/Prize: X=(\d+), Y=(\d+)/)[0]
        if prize
          current_machine[:prize] = prize.map(&:to_i).map { |n| n + 10_000_000_000_000 }
          machines << current_machine
          current_machine = {}
        end
      end
    end

    machines.sum do |machine|
      x_num = (machine[:prize][0] * machine[:b][1]) - (machine[:prize][1] * machine[:b][0])
      x_denom = (machine[:a][0] * machine[:b][1]) - (machine[:a][1] * machine[:b][0])
      x = x_num / x_denom

      y_num = machine[:prize][0] - (machine[:a][0] * x)
      y_denom = machine[:b][0]
      y = y_num / y_denom

      proved = (machine[:a][0] * x) + (machine[:b][0] * y) == machine[:prize][0] &&
               (machine[:a][1] * x) + (machine[:b][1] * y) == machine[:prize][1]

      next 0 unless proved

      (x * 3) + (y * 1)
    end
  end
end
