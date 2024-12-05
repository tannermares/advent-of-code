#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 1
module Day1
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    left_list, right_list = build_lists
    paired_lists = left_list.zip(right_list)

    difference = 0
    paired_lists.each do |pair|
      difference += (pair[0] - pair[1]).abs
    end

    difference
  end

  def self.part2
    left_list, right_list = build_lists

    left_list.sum do |n|
      n * right_list.count(n)
    end
  end

  def self.build_lists
    left_list = []
    right_list = []

    INPUT.each do |row|
      left, right = row.split('   ').map(&:to_i)
      left_list << left
      right_list << right
    end

    left_list.sort!
    right_list.sort!

    [left_list, right_list]
  end
end
