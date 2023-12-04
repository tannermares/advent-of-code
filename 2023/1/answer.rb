#!/usr/bin/env ruby
# frozen_string_literal: true

def part1
  DigitFinder.new(Input.new, /\d/).sum
end

def part2
  DigitFinder.new(Input.new, /(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).sum
end

# Finds digits in given input with pattern
class DigitFinder
  attr_reader :input, :pattern

  def initialize(input, pattern)
    @input = input
    @pattern = pattern
  end

  def sum
    input.sum { |row| NumberConverter.new(row.scan(pattern)).build }
  end
end

# Converts numbers and builds appropriate calibaration value class
class NumberConverter
  attr_reader :numbers

  NUMBERS = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9,
    '1' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9
  }.freeze

  def initialize(numbers)
    @numbers = numbers.flatten.map { |n| NUMBERS[n] }
  end

  def build
    if numbers.empty?
      NilCalibrationValue.new(numbers).to_i
    elsif numbers.length == 1
      SingleCalibrationValue.new(numbers).to_i
    else
      DoubleCalibrationValue.new(numbers).to_i
    end
  end
end

# Base calibration value class to define interface
class CalibrationValue
  attr_reader :numbers

  def initialize(numbers)
    @numbers = numbers
  end

  def to_i
    raise 'not implemented'
  end
end

# Implements calibration value API and returns appropriate nil value
class NilCalibrationValue < CalibrationValue
  def to_i
    0
  end
end

# Implements calibration value API and returns appropriate single value
class SingleCalibrationValue < CalibrationValue
  def to_i
    "#{numbers[0]}#{numbers[0]}".to_i
  end
end

# Implements calibration value API and returns appropriate double value
class DoubleCalibrationValue < CalibrationValue
  def to_i
    "#{numbers[0]}#{numbers[numbers.length - 1]}".to_i
  end
end

# Handles opening file given path_string, delegates sum to file
class Input
  attr_reader :file, :path_string

  def initialize(path_string = 'input.txt')
    @path_string = path_string
    @file = File.foreach(path)
  end

  def sum(...)
    @file.sum(...)
  end

  private

  def path
    File.join(File.dirname(__FILE__), path_string).freeze
  end
end

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
