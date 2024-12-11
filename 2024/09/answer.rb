#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 09
module Day09
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    expanded_disk = []

    INPUT.first.chars.each_slice(2).with_index do |(file_count, free_space), file_id|
      file_count.to_i.times { expanded_disk << file_id }
      free_space.to_i.times { expanded_disk << '.' }
    end

    empty_space_pointer = 0
    compact_pointer = expanded_disk.length - 1

    while empty_space_pointer < compact_pointer
      if expanded_disk[empty_space_pointer] != '.'
        empty_space_pointer += 1
      elsif expanded_disk[compact_pointer] == '.'
        compact_pointer -= 1
      else
        expanded_disk[empty_space_pointer] = expanded_disk[compact_pointer]
        expanded_disk[compact_pointer] = '.'
        empty_space_pointer += 1
        compact_pointer -= 1
      end
    end

    expanded_disk.reject { |n| n == '.' }.map(&:to_i).each_with_index.sum do |n, index|
      n * index
    end
  end

  def self.part2
    expanded_disk = []
    free_space_map = {}
    file_map = {}

    INPUT.first.chars.each_slice(2).with_index do |(file_count, free_space), file_id|
      file_count.to_i.times { expanded_disk << file_id }
      file_map[file_id] = { capacity: file_count.to_i, start: expanded_disk.length - file_count.to_i }

      free_space.to_i.times { expanded_disk << '.' }
      next if free_space.to_i.zero?

      free_space_map[free_space.to_i] ||= []
      free_space_map[free_space.to_i] << expanded_disk.length - free_space.to_i
    end

    file_id = expanded_disk.last

    until file_id.negative?
      file = file_map[file_id]
      available_free_spaces = free_space_map.reject { |_, value| value.empty? }.keys.sort
      possible_gaps = available_free_spaces.filter { |fs| fs >= file[:capacity] }
      min_gap = nil
      free_space_index = Float::INFINITY

      possible_gaps.each do |pg|
        if free_space_map[pg].min < free_space_index
          min_gap = pg
          free_space_index = free_space_map[pg].min
        end
      end

      if !free_space_map[min_gap].nil? && free_space_map[min_gap].first < file[:start]
        if (free_space_start = free_space_map[min_gap]&.shift)
          free_space_end = free_space_start + file[:capacity]

          (free_space_start...free_space_end).each_with_index do |n, i|
            expanded_disk[n] = file_id
            expanded_disk[file[:start] + i] = '.'
          end

          if (left_over_gap = min_gap - file[:capacity])
            free_space_map[left_over_gap] ||= []
            free_space_map[left_over_gap].push(free_space_end).sort!
          end
        end
      end

      file_id -= 1
    end

    expanded_disk.map(&:to_i).each_with_index.sum do |n, index|
      n * index
    end
  end
end
