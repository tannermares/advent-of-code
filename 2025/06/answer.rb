#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 06
module Day06
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    problems = []

    INPUT.each do |row|
      nums = row.squeeze(' ').strip.split
      nums.each_with_index do |n, i|
        problems[i] ||= []
        problems[i] << n
      end
    end

    problems.sum do |problem|
      operator = problem.pop
      problem.map(&:to_i).reduce(&operator.to_sym)
    end
  end

  def self.part2
    input = INPUT.dup
    operators = input.pop.gsub(/\s+/, '').chars.reverse
    new_input = input.map { |row| row.chomp.chars }
    problems = new_input.transpose.map(&:join).map(&:strip)

    sums = []
    sum = nil
    problem_pointer = 0
    problems.reverse.each do |num|
      if num.empty?
        problem_pointer += 1
        sums << sum
        sum = nil
        next
      end

      if sum.nil?
        sum = num.to_i
        next
      end

      sum = sum.send(operators[problem_pointer].to_sym, num.to_i)
    end

    sums.push(sum).sum
  end
end
