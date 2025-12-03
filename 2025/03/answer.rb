#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 03
module Day03
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT.sum do |row|
      largest_number(row.strip.chars, 1)
    end
  end

  def self.part2
    INPUT.sum do |row|
      largest_number(row.strip.chars, 11)
    end
  end

  def self.largest_number(chars, digit)
    digits = []

    until digit.negative?
      index = chars.index(digits.last.to_s)
      chars = chars.slice((index + 1)..) if index
      digits << first_biggest(chars, digit)
      digit -= 1
    end

    digits.join.to_i
  end

  def self.first_biggest(array, digit)
    9.downto(1) do |n|
      index = array.index(n.to_s)
      next unless index && index < array.length - digit

      return n
    end
  end
end
