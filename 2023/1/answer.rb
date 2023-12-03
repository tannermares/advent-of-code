# frozen_string_literal: true

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

def parse_digits(matcher)
  numbers = File.open("#{File.dirname(__FILE__)}/input.txt").map do |cv|
    numbers = cv.scan(matcher).flatten.map { |n| NUMBERS[n] }

    if numbers.empty?
      0
    elsif numbers.length == 1
      "#{numbers[0]}#{numbers[0]}".to_i
    else
      "#{numbers[0]}#{numbers[numbers.length - 1]}".to_i
    end
  end

  numbers.reduce { |acc, n| acc + n }
end

part1 = parse_digits(/\d/)
part2 = parse_digits(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/)

puts "Part 1 Answer: #{part1}"
puts "Part 2 Answer: #{part2}"
