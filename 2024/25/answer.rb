#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

# Day 25
module Day25
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH).map(&:strip).reject(&:empty?)

  def self.part1
    locks = ::Set.new
    keys = ::Set.new
    lock = nil

    INPUT.each_slice(7) do |lk|
      lock = lk.shift == '#####'
      lk.pop
      piece = [0, 0, 0, 0, 0]

      lk.each do |row|
        row.chars.each_with_index { |char, i| piece[i] += char == '#' ? 1 : 0 }
      end

      lock ? locks << piece : keys << piece
    end

    fitting_combos = []

    locks.each do |l|
      keys.each do |k|
        l_and_k = l.zip(k).map { |a, b| a + b }
        next if l_and_k.any? { |n| n > 5 }

        fitting_combos << [l, k]
      end
    end

    fitting_combos.count
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
