#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 22
module Day22
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT.sum do |row|
      secret = row.to_i
      2000.times { secret = generate_secret(secret) }
      secret
    end
  end

  def self.part2
    changes = {}
    possible_bests = {}

    INPUT.each do |row|
      key = row.strip
      secret = row.to_i

      2000.times do |i|
        # prev_secret = secret
        secret = generate_secret(secret)

        # puts '-' * 50
        # puts key
        # puts '-' * 50

        # prev_price = prev_secret.to_s.chars.last.to_i
        current_price = secret.to_s.chars.last.to_i
        changes[key] ||= []
        changes[key] << current_price#{ price: current_price, change: current_price - prev_price }

        possible_best = !(i - 4).negative? && changes[key][i - 4] == current_price
        next unless possible_best

        # if !(i - 4).negative?
        #   puts '-' * 50
        #   p [changes[key][i - 4][:price], ones]
        #   puts '-' * 50
        # end

        sequence = [
          changes[key][i - 3] - changes[key][i - 4],
          changes[key][i - 2] - changes[key][i - 3],
          changes[key][i - 1] - changes[key][i - 2],
          changes[key][i] - changes[key][i - 1]
        ]
        possible_bests[sequence] ||= {}
        possible_bests[sequence][key] ||= []
        possible_bests[sequence][key] << changes[key][i]
      end
    end

    puts '-' * 50
    pp possible_bests.sort.to_h
    # best_sequence, best_prices = possible_bests.max_by { |_, prices| prices.values.sum }

    puts '-' * 50
    # p best_sequence
    # p best_prices
    puts '-' * 50
    0#best_prices.values.sum
  end

  def self.generate_secret(number)
    first = step1(number)
    second = step2(first)
    step3(second)
  end

  def self.step1(number)
    mixed = mix(number * 64, number)
    prune(mixed)
  end

  def self.step2(number)
    mixed = mix(number / 32, number)
    prune(mixed)
  end

  def self.step3(number)
    mixed = mix(number * 2048, number)
    prune(mixed)
  end

  def self.mix(value, secret)
    value ^ secret
  end

  def self.prune(secret)
    secret % 16_777_216
  end
end
