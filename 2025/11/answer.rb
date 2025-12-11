#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 11
module Day11
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.part1
    graph = Hash.new { |hash, key| hash[key] = [] }

    INPUT.each do |row|
      device, outputs = row.split(': ')
      outputs = outputs.split

      graph[device]

      outputs.each do |output|
        graph[device] << output
      end
    end

    walk_graph(graph, 'you', 0)
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.walk_graph(graph, start, count)
    graph[start].each do |n|
      if n == 'out'
        count += 1
      else
        count = walk_graph(graph, n, count)
      end
    end

    count
  end
end
