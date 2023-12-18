#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 15
module Day15
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.hash_sequence(sequence)
    sequence.chars.reduce(0) do |sum, char|
      sum += char.ord
      sum *= 17
      sum % 256
    end
  end

  def self.sum_box(box_number, lenses)
    lenses.each_with_index.reduce(0) do |sum, ((_label, focal_length), index)|
      sum + (box_number + 1) * (index + 1) * focal_length
    end
  end

  def self.sort_lens(boxes, sequence)
    if sequence.end_with?('-')
      label = sequence.split('-').first
      hash = hash_sequence(label)
      boxes[hash] ||= []
      boxes[hash] = boxes[hash].reject { |l, _| l == label }
    else
      label, focal_length = sequence.split('=')
      hash = hash_sequence(label)
      boxes[hash] ||= []
      existing_index = boxes[hash].index { |l, _| l == label }
      new_lens = [label, focal_length.to_i]

      if existing_index
        boxes[hash][existing_index] = new_lens
      else
        boxes[hash] << new_lens
      end
    end

    boxes
  end

  def self.part1
    INPUT[0].split(',').sum { |sequence| hash_sequence(sequence) }
  end

  def self.part2
    boxes = {}
    INPUT[0].split(',') { |sequence| sort_lens(boxes, sequence) }
    boxes.sum { |box_number, lenses| sum_box(box_number, lenses) }
  end
end
