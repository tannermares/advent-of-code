#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 07
module Day07
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    find_solves(%w[+ *].freeze)
  end

  def self.part2
    find_solves(%w[+ * '||'].freeze)
  end

  def self.find_solves(operators)
    INPUT.sum do |row|
      result, nums = row.split(': ').map { |n| n.split(' ').map(&:to_i) }
      combinations = operators.repeated_permutation(nums.length - 1)
      result = result.first

      solvable = combinations.any? do |combination|
        equation = nums.zip(combination).flatten.compact
        result == solve(equation)
      end

      solvable ? result : 0
    end
  end

  def self.solve(equation)
    result = equation[0]

    (1...equation.length).step(2) do |i|
      number = equation[i + 1]
      if equation[i] == '+'
        result += number
      elsif equation[i] == '*'
        result *= number
      else
        result = (result.to_s + number.to_s).to_i
      end
    end

    result
  end
end
