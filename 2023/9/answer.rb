#!/usr/bin/env ruby
# frozen_string_literal: true

SAMPLE = true
INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)

def part1
  INPUT.each_with_index.sum do |row, index|
    steps[index] ||= []
    steps[index] << row.split.map(&:to_i)

    until steps[index].last.uniq == [0]
      last_step = steps[index].last
      next_step = last_step.map.with_index { |n, i| i + 1 < last_step.length ? last_step[i + 1] - n : nil }.compact
      steps[index] << next_step
    end

    reversed = steps[index].reverse
    reversed.each_with_index do |step, i|
      step << 0
      previous_row = reversed[i - 1] unless i.zero?
      step[-1] = step[-2] + previous_row[-1] if previous_row
    end

    steps[index].first.last
  end
end

def part2
  INPUT.each_with_index.sum do |row, index|
    steps[index] ||= []
    steps[index] << row.split.map(&:to_i)

    until steps[index].last.uniq == [0]
      last_step = steps[index].last
      next_step = last_step.map.with_index { |n, i| i + 1 < last_step.length ? last_step[i + 1] - n : nil }.compact
      steps[index] << next_step
    end

    reversed = steps[index].reverse
    reversed.each_with_index do |step, i|
      step << 0
      previous_row = reversed[i - 1] unless i.zero?

      # puts '-' * 50
      # puts "INDEX: #{i}"
      # puts "Step: #{step.inspect}"
      # puts "Previous Row: #{previous_row.inspect}"
      # puts "previous item: #{step[-2]}"
      # puts "adding: #{previous_row[-1]}" if previous_row
      # puts '-' * 50

      step[-1] = step[-2] + previous_row[-1] if previous_row
    end

    steps[index].first.last
  end
end
