#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 08
module Day08
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    junction_boxes = INPUT.map { |row| row.strip.split(',').map(&:to_i) }
    pairs = []
    junction_boxes.repeated_combination(2) { |combination| pairs.push(combination) unless combination.uniq.length == 1 }
    distances = {}
    circuits = junction_boxes.map { |jb| [jb] }

    pairs.each { |pair| distances[pair] = distance(pair[0], pair[1]) }
    sorted_distances = distances.sort_by { |_, value| value }.to_h

    sorted_distances.first(10).each do |(pair, _distance)|
      to_delete = nil

      circuits.each do |circuit|
        if circuit.include?(pair[0]) && circuit.include?(pair[1])
          break
        elsif circuit.include?(pair[0])
          existing_index = circuits.index { |n| n.include?(pair[1]) }

          if existing_index
            to_delete = circuits[existing_index]
            circuit.push(*circuits[existing_index])
          else
            to_delete = [pair[1]]
            circuit.push(pair[1])
          end

          break
        elsif circuit.include?(pair[1])
          existing_index = circuits.index { |n| n.include?(pair[0]) }

          if existing_index
            to_delete = circuits[existing_index]
            circuit.push(*circuits[existing_index])
          else
            to_delete = [pair[0]]
            circuit.push(pair[0])
          end

          break
        end
      end

      circuits.delete(to_delete) if to_delete
    end

    circuits.map(&:length).max(3).reduce(&:*)
  end

  def self.part2
    junction_boxes = INPUT.map { |row| row.strip.split(',').map(&:to_i) }
    pairs = []
    junction_boxes.repeated_combination(2) { |combination| pairs.push(combination) unless combination.uniq.length == 1 }
    distances = {}
    circuits = junction_boxes.map { |jb| [jb] }

    pairs.each { |pair| distances[pair] = distance(pair[0], pair[1]) }
    sorted_distances = distances.sort_by { |_, value| value }.to_h
    last_pair = nil

    sorted_distances.each do |(pair, _distance)|
      break if circuits.any? { |c| c.uniq.length == 20 }

      to_delete = nil
      last_pair = pair

      circuits.each do |circuit|
        if circuit.include?(pair[0]) && circuit.include?(pair[1])
          break
        elsif circuit.include?(pair[0])
          existing_index = circuits.index { |n| n.include?(pair[1]) }

          if existing_index
            to_delete = circuits[existing_index]
            circuit.push(*circuits[existing_index])
          else
            to_delete = [pair[1]]
            circuit.push(pair[1])
          end

          break
        elsif circuit.include?(pair[1])
          existing_index = circuits.index { |n| n.include?(pair[0]) }

          if existing_index
            to_delete = circuits[existing_index]
            circuit.push(*circuits[existing_index])
          else
            to_delete = [pair[0]]
            circuit.push(pair[0])
          end

          break
        end
      end

      circuits.delete(to_delete) if to_delete
    end

    last_pair[0][0] * last_pair[1][0]
  end

  def self.distance(point_one, point_two)
    Math.sqrt(
      ((point_two[0] - point_one[0])**2) +
      ((point_two[1] - point_one[1])**2) +
      ((point_two[2] - point_one[2])**2)
    )
  end
end
