#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 24
module Day24
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH).map(&:strip)
  BOOLEAN = {
    1 => true,
    0 => false
  }.freeze
  GATES = {
    'AND' => ->(a, b) { BOOLEAN[a] && BOOLEAN[b] ? 1 : 0 },
    'OR' => ->(a, b) { BOOLEAN[a] || BOOLEAN[b] ? 1 : 0 },
    'XOR' => ->(a, b) { BOOLEAN[a] != BOOLEAN[b] ? 1 : 0 }
  }.freeze

  def self.part1
    wires = {}
    z_wires = []
    gates = []
    gate_pointer = 0

    INPUT.each do |row|
      next if row.empty?

      if row.include?(':')
        wire, value = row.split(': ')
        wires[wire] = value.to_i
      else
        input1, gate, input2, _, output = row.split(' ')
        z_match = output.match(/z(\d{2})/)
        z_wires[z_match[1].to_i] = nil if z_match
        gates << { input1:, gate:, input2:, output: }
      end
    end

    while z_wires.any?(&:nil?)
      if wires[gates[gate_pointer][:input1]].nil? || wires[gates[gate_pointer][:input2]].nil?
        if gate_pointer + 1 == gates.length
          gate_pointer = 0
        else
          gate_pointer += 1
        end
        next
      end

      gate = gates[gate_pointer]
      wires[gate[:output]] = GATES[gate[:gate]].call(wires[gate[:input1]], wires[gate[:input2]])
      z_match = gate[:output].match(/z(\d{2})/)
      z_wires[z_match[1].to_i] = wires[gate[:output]] if z_match

      if gate_pointer + 1 == gates.length
        gate_pointer = 0
      else
        gate_pointer += 1
      end
    end

    z_wires.reverse.join.to_i(2)
  end

  def self.part2
    wires = {}
    z_wires = []
    gates = []
    gate_pointer = 0

    INPUT.each do |row|
      next if row.empty?

      if row.include?(':')
        wire, value = row.split(': ')
        wires[wire] = value.to_i
      else
        input1, gate, input2, _, output = row.split(' ')
        z_match = output.match(/z(\d{2})/)
        z_wires[z_match[1].to_i] = nil if z_match
        gates << { input1:, gate:, input2:, output: }
      end
    end

    while z_wires.any?(&:nil?)
      if wires[gates[gate_pointer][:input1]].nil? || wires[gates[gate_pointer][:input2]].nil?
        if gate_pointer + 1 == gates.length
          gate_pointer = 0
        else
          gate_pointer += 1
        end
        next
      end

      gate = gates[gate_pointer]
      wires[gate[:output]] = GATES[gate[:gate]].call(wires[gate[:input1]], wires[gate[:input2]])
      z_match = gate[:output].match(/z(\d{2})/)
      z_wires[z_match[1].to_i] = wires[gate[:output]] if z_match

      if gate_pointer + 1 == gates.length
        gate_pointer = 0
      else
        gate_pointer += 1
      end
    end

    z_gates = gates.select { |g| g[:output].start_with?('z') }
    output = z_gates.map { |g| g[:output] }.reverse
    sorted = output.dup.sort
    swaps = []

    z_gates.each_with_index do |g, idx|
      next if g[:output] == sorted[idx]

      index = output.index(sorted[idx])
      output[index] = output[idx]
      output[idx] = sorted[idx]

      swaps += [output[index], output[idx]]
    end

    swaps.join(',')
  end
end
