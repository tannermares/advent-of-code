#!/usr/bin/env ruby
# frozen_string_literal: true

SAMPLE = true
INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)

def build_steps(row)
  steps = [row.split.map(&:to_i)]

  until steps.last.uniq == [0]
    last_step = steps.last
    next_step = last_step.map.with_index { |n, i| i + 1 < last_step.length ? last_step[i + 1] - n : nil }.compact
    steps << next_step
  end

  steps.reverse
end

def part1
  INPUT.sum do |row|
    answers = []
    steps = build_steps(row)

    steps.each_with_index do |step, i|
      step << 0
      previous_row = steps[i - 1] unless i.zero?
      change = previous_row ? step[-2] + previous_row[-1] : 0
      step[-1] = change
      answers << change if i == steps.length - 1
    end

    answers.sum
  end
end

def part2
  INPUT.sum do |row|
    answers = []
    steps = build_steps(row)

    steps.each_with_index do |step, i|
      step.unshift(0)
      previous_row = steps[i - 1] unless i.zero?
      change = previous_row ? step[1] - previous_row[0] : 0
      step[0] = change
      answers << change if i == steps.length - 1
    end

    answers.sum
  end
end
