#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 05
module Day05
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  SEPARATOR_INDEX = INPUT.find_index("\n")
  RAW_RULES = INPUT.map(&:strip)[...SEPARATOR_INDEX]
  PAGES = INPUT.map(&:strip)[(SEPARATOR_INDEX + 1)..]
  RULES = {}

  RAW_RULES.each do |rule|
    before, after = rule.split('|')
    RULES[before] ||= { before: [], after: [] }
    RULES[after] ||= { before: [], after: [] }

    RULES[before][:before] << after
    RULES[after][:after] << before
  end

  def self.part1
    PAGES.sum do |row|
      pages = row.split(',')
      correct_order = correct_order?(pages)

      correct_order ? pages[pages.length / 2].to_i : 0
    end
  end

  def self.part2
    PAGES.sum do |row|
      pages = row.split(',')
      correct_order = correct_order?(pages)
      next 0 if correct_order

      fixed_pages = fix_pages!(pages)
      fixed_pages[fixed_pages.length / 2].to_i
    end
  end

  def self.valid_page?(pages, page, index)
    return false if (index + 1) != pages.length && RULES[page][:after].include?(pages[index + 1])
    return false if (index - 1) != -1 && RULES[page][:before].include?(pages[index - 1])

    true
  end

  def self.correct_order?(pages)
    pages.each_with_index.all? do |page, index|
      valid_page?(pages, page, index)
    end
  end

  def self.fix_pages!(pages)
    maybe_fixed_pages = pages

    until correct_order?(maybe_fixed_pages) do
      maybe_fixed_pages.map.with_index do |page, index|
        next if valid_page?(maybe_fixed_pages, page, index)

        if RULES[page][:after].include?(maybe_fixed_pages[index + 1])
          temp_page = maybe_fixed_pages[index + 1]
          maybe_fixed_pages[index + 1] = page
          maybe_fixed_pages[index] = temp_page
        end
      end
    end

    maybe_fixed_pages
  end
end
