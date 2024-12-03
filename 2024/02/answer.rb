#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 2
module Day2
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT.sum do |row|
      nums = row.split(' ').map(&:to_i)
      level_safe(nums) ? 1 : 0
    end
  end

  def self.part2
    INPUT.sum do |row|
      nums = row.split(' ').map(&:to_i)

      next 1 if level_safe(nums)

      index_to_drop = 0
      eventually_safe = false

      while index_to_drop < nums.length
        new_nums = nums.reject.with_index { |_, index| index == index_to_drop }
        index_to_drop += 1
        if level_safe(new_nums)
          eventually_safe = true
          break
        end
      end

      eventually_safe ? 1 : 0
    end
  end

  def self.level_safe(nums)
    prev = nums.first
    return false if nums.first == nums.last

    asc = nums.first < nums.last
    nums.drop(1).each do |n|
      if within_bounds(asc, prev, n)
        prev = n
        next
      end

      return false
    end

    true
  end

  def self.within_bounds(asc, prev, num)
    if asc
      prev == num - 1 || prev == num - 2 || prev == num - 3
    else
      prev == num + 1 || prev == num + 2 || prev == num + 3
    end
  end
end
