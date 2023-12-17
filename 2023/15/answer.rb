#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 15
module Day15
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.hash_sequence(sequence)
    sequence.chars.reduce(0) do |sum, char|
      sum += char.ord
      sum *= 17
      sum % 256
    end
  end

  def self.part1
    INPUT[0].split(',').sum { |sequence| hash_sequence(sequence) }
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
