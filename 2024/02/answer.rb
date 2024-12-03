#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 2
module Day2
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT.sum do |row|
      safe = true
      nums = row.split(' ').map(&:to_i)
      prev = nums.first
      asc = nums.first < nums.last

      nums.drop(1).each do |n|
        if within_bounds(asc, prev, n)
          prev = n
          next
        end

        safe = false
        break
      end

      safe ? 1 : 0
    end
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.within_bounds(asc, prev, n)
    if asc
      prev == n - 1 || prev == n - 2 || prev == n - 3
    else
      prev == n + 1 || prev == n + 2 || prev == n + 3
    end
  end
end
