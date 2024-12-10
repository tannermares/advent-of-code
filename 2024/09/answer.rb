#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 09
module Day09
  SAMPLE = false
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    expanded_disk = []

    INPUT.first.chars.each_slice(2).with_index do |(file_count, free_space), index|
      file_count.to_i.times do
        expanded_disk << index
      end

      free_space.to_i.times do
        expanded_disk << '.'
      end
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

    INPUT.first.chars.each_slice(2).with_index do |(file_count, free_space), index|
      file_count.to_i.times { expanded_disk << index }
      file_map[index] = file_count.to_i

      free_space.to_i.times { expanded_disk << '.' }
      next if free_space.to_i.zero?

      free_space_map[free_space.to_i] ||= []
      free_space_map[free_space.to_i] << expanded_disk.length - free_space.to_i
    end

    file_id = expanded_disk.last
    file_id_pointer = expanded_disk.length - 1

    available_free_spaces = free_space_map.keys.sort

    while file_id > -1
      file_count = file_map[file_id]
      min_gap = available_free_spaces.find { |fs| fs >= file_count }

      if (free_space_start = free_space_map[min_gap]&.shift)
        if (min_gap - file_count).positive?
          free_space_map[min_gap - file_count] ||= []
          free_space_map[min_gap - file_count].push(free_space_start + file_count).sort!
        end

        (free_space_start...free_space_start + file_count).each_with_index do |n, i|
          expanded_disk[n] = file_id
          expanded_disk[file_id_pointer - i] = '.'
        end
      end

      file_id -= 1
      file_id_pointer -= 1 while expanded_disk[file_id_pointer] != file_id && file_id != -1
    end

    expanded_disk.map(&:to_i).each_with_index.sum do |n, index|
      n * index
    end
  end
end
