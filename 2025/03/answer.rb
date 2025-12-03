#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 03
module Day03
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT.sum do |row|
      first = nil
      second = nil
      chars = row.strip.chars

      9.downto(0) do |n|
        first_index = chars.index(n.to_s)

        next unless first_index && first_index < row.length - 2

        first = n
        break
      end

      row_half = chars.slice((chars.index(first.to_s) + 1)..).reverse

      9.downto(0) do |m|
        second_index = row_half.index(m.to_s)

        next unless second_index

        second = m
        break
      end

      "#{first}#{second}".to_i
    end
  end

  def self.part2
    INPUT.sum do |row|
    end
  end
end
