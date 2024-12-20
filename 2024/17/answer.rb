#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 17
module Day17
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)
  OPCODES = %i[
    adv
    bxl
    bst
    jnz
    bxc
    out
    bdv
    cdv
  ].freeze

  def self.part1
    state = {
      registers: { a: 0, b: 0, c: 0 },
      instruction_pointer: 0,
      output: [],
      program: []
    }

    INPUT.each do |row|
      register_a = row.match(/Register A: (\d*)/)
      register_b = row.match(/Register B: (\d*)/)
      register_c = row.match(/Register C: (\d*)/)
      program = row.match(/Program: (.*)/)

      state[:registers][:a] = register_a[1].to_i if register_a
      state[:registers][:b] = register_b[1].to_i if register_b
      state[:registers][:c] = register_c[1].to_i if register_c
      state[:program] = program[1].split(',').map(&:to_i) if program
    end

    while state[:instruction_pointer] < state[:program].length
      opcode = state[:program][state[:instruction_pointer]]
      operand = state[:program][state[:instruction_pointer] + 1]
      send(OPCODES[opcode], operand, state)
    end

    state[:output].join(',')
  end

  def self.part2
    max_needle = 1_000_000_000
    min_needle = 0
    needle = max_needle / 2

    state = {
      registers: { a: needle, b: 0, c: 0 },
      instruction_pointer: 0,
      output: [],
      program: []
    }

    INPUT.each do |row|
      program = row.match(/Program: (.*)/)
      state[:program] = program[1].split(',').map(&:to_i) if program
    end

    while state[:output] != state[:program]
      unless state[:output].empty?
        if state[:output].join('').to_i > state[:program].join('').to_i
          max_needle = needle
          needle = (max_needle / 2).floor
          puts '-' * 50
          puts 'OUTPUT TOO HIGH'
          puts "needle: #{needle}"
          p [min_needle, max_needle]
          puts "Current output: #{state[:output].join('').to_i}"
          puts '-' * 50
        else
          min_needle = needle
          needle = (min_needle * 1.5).floor
          puts '-' * 50
          puts 'OUTPUT TOO LOW'
          puts "needle: #{needle}"
          p [min_needle, max_needle]
          puts "Current output: #{state[:output].join('').to_i}"
          puts '-' * 50
        end
      end

      state[:registers][:a] = needle
      state[:registers][:b] = 0
      state[:registers][:c] = 0
      state[:instruction_pointer] = 0
      state[:output] = []

      while state[:instruction_pointer] < state[:program].length
        opcode = state[:program][state[:instruction_pointer]]
        operand = state[:program][state[:instruction_pointer] + 1]
        send(OPCODES[opcode], operand, state)
      end

      sleep(1)
    end
  end

  def self.adv(operand, state)
    state[:registers][:a] = state[:registers][:a] / 2**combo_operand_for(operand, state)
    state[:instruction_pointer] += 2
  end

  def self.bxl(operand, state)
    state[:registers][:b] = state[:registers][:b] ^ operand
    state[:instruction_pointer] += 2
  end

  def self.bst(operand, state)
    state[:registers][:b] = combo_operand_for(operand, state) % 8
    state[:instruction_pointer] += 2
  end

  def self.jnz(operand, state)
    if state[:registers][:a].zero?
      state[:instruction_pointer] += 2
    else
      state[:instruction_pointer] = operand
    end
  end

  def self.bxc(_, state)
    state[:registers][:b] = state[:registers][:b] ^ state[:registers][:c]
    state[:instruction_pointer] += 2
  end

  def self.out(operand, state)
    state[:output] << combo_operand_for(operand, state) % 8
    state[:instruction_pointer] += 2
  end

  def self.bdv(operand, state)
    state[:registers][:b] = state[:registers][:a] / 2**combo_operand_for(operand, state)
    state[:instruction_pointer] += 2
  end

  def self.cdv(operand, state)
    state[:registers][:c] = state[:registers][:a] / 2**combo_operand_for(operand, state)
    state[:instruction_pointer] += 2
  end

  def self.combo_operand_for(operand, state)
    case operand
    when 0..3
      operand
    when 4
      state[:registers][:a]
    when 5
      state[:registers][:b]
    when 6
      state[:registers][:c]
    when 7
      raise 'Operand Reserved'
    end
  end
end
