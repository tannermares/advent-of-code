#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 16
module Day16
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  GRID = INPUT.map { |row| row.strip.chars }
  MOVE_SCORE = 1
  ROTATE_SCORE = 1_000
  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]].freeze

  def self.part1
    maze_start, maze_end = find_maze_positions
    current_position = maze_start
    current_direction = 1

    graph = {}
    visited = []

    # Builds Weighted Graph
    weigh_neighbors(current_position, current_direction, graph, visited)

    parents = {}
    costs = {}
    processed = []

    graph.each_value do |neighbors|
      neighbors.each_key do |neighbor|
        parents[neighbor] = nil
        costs[neighbor] = Float::INFINITY
      end
    end

    graph[maze_start].each do |neighbor, cost|
      parents[neighbor] = maze_start
      costs[neighbor] = cost
    end
    costs[maze_end] = Float::INFINITY

    node = find_lowest_cost_node(costs, processed)

    until node.nil?
      cost = costs[node]
      break unless graph[node]

      graph[node].each do |neighbor, neighbor_cost|
        new_cost = cost + neighbor_cost
        if costs[neighbor] > new_cost
          costs[neighbor] = new_cost
          parents[neighbor] = node
        end
      end
      processed << node
      node = find_lowest_cost_node(costs, processed)
    end

    puts '-' * 50
    pp graph
    puts '-' * 50

    puts '-' * 50
    current_node = maze_end
    until current_node == maze_start
      p [current_node, costs[current_node]]
      current_node = parents[current_node]
    end
    puts '-' * 50

    costs[maze_end]
  end

  def self.part2
    INPUT.sum do |row|
    end
  end

  def self.weigh_neighbors(current_position, current_direction, graph, visited)
    return if GRID.dig(*current_position.reverse) == 'E'

    visited << current_position
    graph[current_position] ||= {}

    DIRECTIONS.map.with_index do |direction, index|
      next_position = current_position.zip(direction).map(&:sum)
      next if GRID.dig(*next_position.reverse) == '#'

      next_cost = index == current_direction ? 1 : 1001
      current_cost = graph[current_position][next_position] || Float::INFINITY
      next if visited.include?(next_position)# && next_cost >= current_cost

      graph[current_position][next_position] = next_cost
      weigh_neighbors(next_position, index, graph, visited)
    end
  end

  def self.find_maze_positions
    maze_start = nil
    maze_end = nil

    GRID.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        maze_start = [j, i] if cell == 'S'
        maze_end = [j, i] if cell == 'E'
      end
    end

    [maze_start, maze_end]
  end

  def self.find_lowest_cost_node(costs, processed)
    lowest_cost = Float::INFINITY
    lowest_cost_node = nil

    costs.each do |node, cost|
      next if processed.include?(node)
      next if lowest_cost < cost

      lowest_cost = cost
      lowest_cost_node = node
    end

    lowest_cost_node
  end
end
