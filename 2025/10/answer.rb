#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 10
module Day10
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    INPUT.sum do |row|
      machine, *buttons, _joltages = row.split
      machine = machine.gsub(/[\[\]]/, '').chars.map { |c| c == '#' ? 1 : 0 }
      buttons = buttons.map do |b|
        clean_buttons = b.gsub(/[)(]/, '').split(',').map(&:to_i)
        new_array = Array.new(machine.length)
        new_array.map.with_index { |_, i| clean_buttons.include?(i) ? 1 : 0 }
      end
      pair = nil
      combo_index = 1

      until pair
        buttons.map { |b| b.join.to_i(2) }.repeated_combination(combo_index) do |combo|
          next unless combo.reduce(&:^) == machine.join.to_i(2)

          pair = combo
          break
        end
        combo_index += 1
      end

      pair.length
    end
  end

  def self.part2
    INPUT.sum do |row|
      _machine, *buttons, joltages = row.split
      joltages = joltages.gsub(/[{}]/, '').split(',').map(&:to_i)
      buttons = buttons.map do |b|
        clean_buttons = b.gsub(/[)(]/, '').split(',').map(&:to_i)
        new_array = Array.new(joltages.length)
        new_array.map.with_index { |_, i| clean_buttons.include?(i) ? 1 : 0 }
      end
      pair = nil
      combo_index = joltages.max
      max_index = joltages.index(joltages.max)

      until pair
        buttons.repeated_permutation(combo_index) do |combo|
          next unless combo.sum { |n| n[max_index] } == joltages.max
          next unless combo.transpose.map { |x| x.reduce(:+) } == joltages

          pair = combo
          break
        end

        combo_index += 1
      end

      pair.length
    end
  end
end
