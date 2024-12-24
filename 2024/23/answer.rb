#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 23
module Day23
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    pairs = {}
    networks = []

    INPUT.each do |row|
      comp1, comp2 = row.strip.split('-')

      pairs[comp1] ||= []
      pairs[comp1] << comp2

      pairs[comp2] ||= []
      pairs[comp2] << comp1
    end

    possible_networks = pairs.filter { |_, v| v.length > 1 }
    processed = []
    possible_networks.each do |key, matches|
      current_match_pointer = 0
      next_match_pointer = 1

      until current_match_pointer == matches.length - 1
        current_match = matches[current_match_pointer]
        next_match = matches[next_match_pointer]

        next_match_pointer += 1

        if next_match_pointer == matches.length
          current_match_pointer += 1
          next_match_pointer = 0
        end

        next if processed.include?(current_match) || processed.include?(next_match)

        potential_network = [key, current_match, next_match].sort

        if pairs[current_match].include?(next_match) && !networks.include?(potential_network)
          networks << potential_network
        end
      end
      processed << key
    end

    networks.filter { |n| n.any? { |c| c.start_with?('t') } }.count
  end

  def self.part2
    pairs = {}
    networks = []

    INPUT.each do |row|
      comp1, comp2 = row.strip.split('-')

      pairs[comp1] ||= []
      pairs[comp1] << comp2

      pairs[comp2] ||= []
      pairs[comp2] << comp1
    end

    possible_networks = pairs.filter { |_, v| v.length > 2 }
    processed = []
    possible_networks.each do |key, matches|
      potential_matches = [matches]
      matches.each { |match| potential_matches << pairs[match] }
      potential_network = potential_matches.flatten.sort.tally

      if !potential_network.empty? && !networks.include?(potential_network)
        networks << potential_network.select { |_, v| v >= 3 }
      end
      processed << key
    end

    pp networks

    networks.map(&:keys).uniq.map { |n| n.join(',') }.filter { |n| n.include?(',t') }.max_by(&:length)
  end
end
