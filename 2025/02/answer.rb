#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 02
module Day02
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT[0].split(',').sum do |row|
      invalid = []
      low, high = row.split('-').map(&:to_i)

      (low..high).to_a.each do |n|
        n_string = n.to_s
        length = n_string.length
        mid = length / 2

        first = n_string.slice(0, mid)
        second = n_string.slice(mid..)

        invalid << n if first == second
      end

      invalid.sum
    end
  end

  def self.part2
    INPUT[0].split(',').sum do |row|
      invalid = []
      low, high = row.split('-').map(&:to_i)

      (low..high).to_a.each do |n|
        n_string = n.to_s
        length = n_string.length
        mid = length / 2

        mid.downto(1) do |m|
          if n.to_s.chars.each_slice(m).map(&:join).uniq.size == 1
            invalid << n
            break
          end
        end
      end

      invalid.sum
    end
  end
end
