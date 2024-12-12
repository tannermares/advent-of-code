#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 4
module Day4
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT.sum do |row|
      _card_number, numbers = row.split(': ')
      winning_numbers, my_numbers = numbers.split(' | ').map(&:split)
      matches = (winning_numbers & my_numbers).length

      if matches.positive?
        score = 1
        (matches - 1).times { score *= 2 }
        score
      else
        0
      end
    end
  end

  def self.part2
    cards = Array.new(INPUT.length).fill(0)

    INPUT.each_with_index do |row, index|
      _card_number, numbers = row.split(': ')
      winning_numbers, my_numbers = numbers.split(' | ').map(&:split)
      matches = (winning_numbers & my_numbers).length
      cards[index] += 1

      cards[index].times do
        matches.times do |n|
          cards[index + n + 1] += 1
        end
      end
    end

    cards.sum
  end
end
