#!/usr/bin/env ruby
# frozen_string_literal: true

SAMPLE = false
INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
INPUT = File.readlines(INPUT_PATH)

NORMAL_RANKS = {
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
JOKER_RANKS = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  'T' => 10,
  '9' => 9,
  '8' => 8,
  '7' => 7,
  '6' => 6,
  '5' => 5,
  '4' => 4,
  '3' => 3,
  '2' => 2,
  'J' => 1
}.freeze

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
  elsif sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] == sorted_hand[3] && sorted_hand[3] != sorted_hand[4] || 
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] == sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[3] == sorted_hand[4] ||
        sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[3] == sorted_hand[4]
    2
  elsif sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[3] != sorted_hand[4] || 
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] == sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[3] != sorted_hand[4] ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] == sorted_hand[3] && sorted_hand[3] != sorted_hand[4] ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[3] == sorted_hand[4]
    1
  elsif sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[3] != sorted_hand[4]
    0
  else
    raise "Invalid type for: #{sorted_hand}"
  end
end

def type_hand_with_jokers(hand)
  # Sort Jokers to the bottom
  sorted_hand = hand.each_char.sort_by { |s| s =~ /^J$/ ? [2, Regexp.last_match[0]] : [1, s] }
  number_of_jokers = sorted_hand.count('J')

  if sorted_hand[0] == sorted_hand[3] && number_of_jokers == 1 ||
     sorted_hand[0] == sorted_hand[2] && number_of_jokers == 2 ||
     sorted_hand[0] == sorted_hand[1] && number_of_jokers == 3 ||
     number_of_jokers == 4 ||
     number_of_jokers == 5
    6
  elsif sorted_hand[0] == sorted_hand[2] && number_of_jokers == 1 && sorted_hand[2] != sorted_hand[3] ||
        sorted_hand[0] != sorted_hand[1] && number_of_jokers == 1 && sorted_hand[1] == sorted_hand[3] ||
        sorted_hand[0] == sorted_hand[1] && number_of_jokers == 2 && sorted_hand[1] != sorted_hand[2] ||
        sorted_hand[0] != sorted_hand[1] && number_of_jokers == 2 && sorted_hand[1] == sorted_hand[2] ||
        number_of_jokers == 3 && sorted_hand[0] != sorted_hand[1]
    5
  elsif sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] == sorted_hand[3] && number_of_jokers == 1
    4
  elsif sorted_hand[0] == sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && number_of_jokers == 1 ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] == sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && number_of_jokers == 1 ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] == sorted_hand[3] && number_of_jokers == 1 ||
        sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && number_of_jokers == 2
    3
  elsif sorted_hand[0] != sorted_hand[1] && sorted_hand[1] != sorted_hand[2] && sorted_hand[2] != sorted_hand[3] && sorted_hand[3] != sorted_hand[4] && number_of_jokers == 1
    1
  else
    raise "Invalid type for: #{sorted_hand}"
  end
end

def type_hands(hands_with_scores, with_wilds: false)
  hands_with_scores.reduce([]) do |acc, hand_with_score|
    type = if with_wilds && hand_with_score[0].include?('J')
      type_hand_with_jokers(hand_with_score[0])
    else
      type_hand(hand_with_score[0])
    end

    acc[type] ||= []
    acc[type] << hand_with_score
    acc
  end
end

def sort_hands(typed_with_scores, ranks: NORMAL_RANKS)
  typed_with_scores.map do |typed_hands_with_scores|
    next unless typed_hands_with_scores

    typed_hands_with_scores.sort do |a, b|
      first_diff_index = 0
      first_diff_index += 1 while a[0][first_diff_index] == b[0][first_diff_index]

      ranks[a[0][first_diff_index]] <=> ranks[b[0][first_diff_index]]
    end
  end
end

def sum_ranks(sorted_typed_with_scores)
  sorted_typed_with_scores.compact.flatten.each_slice(2).with_index.sum do |(_hand, score), rank|
    score.to_i * (rank + 1)
  end
end

def part1
  hands_with_scores = INPUT.map(&:split)
  typed_with_scores = type_hands(hands_with_scores)
  sorted_typed_with_scores = sort_hands(typed_with_scores)
  sum_ranks(sorted_typed_with_scores)
end

def part2
  hands_with_scores = INPUT.map(&:split)
  typed_with_scores = type_hands(hands_with_scores, with_wilds: true)
  sorted_typed_with_scores = sort_hands(typed_with_scores, ranks: JOKER_RANKS)
  sum_ranks(sorted_typed_with_scores)
end
