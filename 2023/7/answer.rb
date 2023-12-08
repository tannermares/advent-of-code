#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT_PATH = File.join(File.dirname(__FILE__), 'sample.txt').freeze
INPUT = File.readlines(INPUT_PATH)

RANKS = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  'J' => 11,
  'T' => 10,
  '9' => 9,
  '8' => 8,
  '7' => 7,
  '6' => 6,
  '5' => 5,
  '4' => 4,
  '3' => 3,
  '2' => 2
}.freeze
TYPES = ['five of a kind', 'four of a kind', 'full house', 'three of a kind', 'two pair', 'one pair', 'high card'].reverse

def type_hand(hand)
  sorted_hand = hand.each_char.sort

  if sorted_hand[0] == sorted_hand[4]
    6
  elsif sorted_hand[0] == sorted_hand[3] || sorted_hand[1] == sorted_hand[4]
    5
  elsif sorted_hand[0] == sorted_hand[2] && sorted_hand[3] == sorted_hand[4] || sorted_hand[0] == sorted_hand[1] && sorted_hand[2] == sorted_hand[4]
    4
  elsif sorted_hand[0] == sorted_hand[2] && sorted_hand[3] != sorted_hand[4] || 
        sorted_hand[0] != sorted_hand[1] && sorted_hand[2] == sorted_hand[4] ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] == sorted_hand[3] && sorted_hand[3] != sorted_hand[4]
    3
  elsif sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] == sorted_hand[3] && sorted_hand[03] != sorted_hand[4] || 
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] == sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[03] == sorted_hand[4] ||
        sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[03] == sorted_hand[4]
    2
  elsif sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[03] != sorted_hand[4] || 
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] == sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[03] != sorted_hand[4] ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] == sorted_hand[3] && sorted_hand[03] != sorted_hand[4] ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[03] == sorted_hand[4]
    1
  elsif sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[03] != sorted_hand[4]
    0
  else
    raise 'WAT'
  end
end

def type_hands(hands_with_scores)
  hands_with_scores.reduce([]) do |acc, hand_with_score|
    type = type_hand(hand_with_score[0])
    acc[type] ||= []
    acc[type] << hand_with_score
    acc
  end
end

def sort_hands(typed_with_scores)
  typed_with_scores.map do |typed_hands_with_scores|
    next unless typed_hands_with_scores
    typed_hands_with_scores.sort do |a, b|
      first_diff_index = 0
      first_diff_index += 1 while a[0][first_diff_index] == b[0][first_diff_index]

      RANKS[a[0][first_diff_index]] <=> RANKS[b[0][first_diff_index]]
    end
  end
end

def part1
  hands_with_scores = INPUT.map(&:split)
  typed_with_scores = type_hands(hands_with_scores)
  sorted_typed_with_scores = sort_hands(typed_with_scores)
  # puts '-' * 50
  # sorted_typed_with_scores.each_with_index do |hands, index|
  #   puts TYPES[index]
  #   puts hands.inspect
  # end
  # puts sorted_typed_with_scores.flatten.inspect
  # puts '-' * 50
  sorted_typed_with_scores.compact.flatten.each_slice(2).with_index.sum do |(_hand, score), rank|
    score.to_i * (rank + 1)
  end
end

def part2
end

puts "Part 1 Answer: #{part1}"
# puts "Part 2 Answer: #{part2}"
