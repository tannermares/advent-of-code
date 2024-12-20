#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 17
module Day17
  SAMPLE = false
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

    while state[:instruction_pointer] <= state[:program].length - 1
      opcode = state[:program][state[:instruction_pointer]]
      operand = state[:program][state[:instruction_pointer] + 1]
      send(OPCODES[opcode], operand, state)
    end

    state[:output].join('')
  end

  def self.part2
    INPUT.sum do |row|
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
