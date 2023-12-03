require 'test/unit'
require 'stringio'
require_relative 'answer'

class Day1 < Test::Unit::TestCase
  def test_part1
    original_stdout = $stdout
    $stdout = StringIO.new

    part1

    $stdout.rewind
    output = $stdout.string
    $stdout = original_stdout

    assert_equal("Part 1 Answer: 53334\n", output)
  end

  def test_part2
    original_stdout = $stdout
    $stdout = StringIO.new

    part2

    $stdout.rewind
    output = $stdout.string
    $stdout = original_stdout

    assert_equal("Part 2 Answer: 52834\n", output)
  end
end
