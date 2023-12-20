#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 19
module Day19
  SAMPLE = true
  INPUT_PATH = File.join(File.dirname(__FILE__), SAMPLE ? 'sample.txt' : 'input.txt').freeze
  INPUT = File.readlines(INPUT_PATH)

  def self.simple_parse_workflow(workflow_string)
    workflow_name, rules = workflow_string.split('{')
    rules_array = rules.gsub(/\}/, '').split(',')
    rules = rules_array.map do |rule|
      condition, destination = rule.split(':')
      property, value = condition.split(/>|</)
      gtolt = condition.scan(/>|</).first
      possibilities =
        if gtolt == '<'
          value.to_i - 1
        else
          4000 - value.to_i + 1
        end

      { possibilities => destination }
    end

    { workflow_name.to_sym => rules }
  end

  def self.parse_workflow(workflow_string)
    workflow_name, rules = workflow_string.split('{')
    rules_array = rules.gsub(/\}/, '').split(',')
    rule_procs = rules_array.map do |rule|
      condition, destination = rule.split(':')
      property, value = condition.split(/>|</)
      gtolt = condition.scan(/>|</).first

      if condition == property
        proc { |_| condition.to_sym }
      else
        proc { |part| part[property.to_sym].send(gtolt.to_sym, value.to_i) ? destination.to_sym : nil }
      end
    end

    { workflow_name.to_sym => rule_procs }
  end

  def self.parse_parts(parts_string)
    parts_string.gsub(/\{|\}/, '').split(',').each_with_object({}) do |rating, acc|
      property, value = rating.split('=')
      acc[property.to_sym] = value.to_i
    end.merge(current_workflow: :in)
  end

  def self.sum_accepted(parts)
    parts.sum { |p| p.except(:current_workflow).values.sum }
  end

  def self.part1
    workflows = {}
    parts = []
    parsing_section = 'WORKFLOWS'

    INPUT.each do |row|
      next parsing_section = 'PARTS' if row == "\n"

      if parsing_section == 'WORKFLOWS'
        workflows.merge!(parse_workflow(row.strip))
      else
        parts << parse_parts(row.strip)
      end
    end

    workflows.merge!({ A: [proc { |_| :A }] })
    workflows.merge!({ R: [proc { |_| :R }] })

    until parts.all? { |part| %i[A R].include?(part[:current_workflow]) }
      parts.each do |part|
        rule_applied = false

        workflows[part[:current_workflow]].each do |rule|
          next if rule_applied

          if rule.call(part)
            rule_applied = true
            part[:current_workflow] = rule.call(part)
          end
        end
      end
    end

    sum_accepted(parts.select { |p| p[:current_workflow] == :A })
  end

  def self.part2
    workflows = {}
    current_node = :in

    INPUT.each do |row|
      break if row == "\n"

      workflows.merge!(simple_parse_workflow(row.strip))
    end

    puts workflows
  end
end
