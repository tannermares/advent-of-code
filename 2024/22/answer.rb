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
    changes = Hash.new([])

    INPUT.sum do |row|
      secret = row.to_i

      2000.times do
        prev_secret = secret
        secret = generate_secret(secret)

        prev_ones = prev_secret.to_s.chars.last.to_i
        ones = secret.to_s.chars.last.to_i

        changes[row] << { price: ones, change: ones - prev_ones }
      end
      0
    end
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
