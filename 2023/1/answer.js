#!/usr/bin/env node

const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, './input.txt'))
  .toString()
  .split('\n')
const NUMBERS = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
  7: 7,
  8: 8,
  9: 9,
}

function parseDigits(matcher) {
  return input
    .map((cv) => {
      const numbers = [...cv.matchAll(matcher)].map((n) => NUMBERS[n])

      if (numbers.length === 0) return 0
      if (numbers.length === 1) return parseInt(`${numbers[0]}${numbers[0]}`)
      return parseInt(`${numbers[0]}${numbers[numbers.length - 1]}`)
    })
    .reduce((n, acc) => (acc += n))
}

function part1() {
  const part1 = parseDigits(/\d/g)
  const answer = `Part 1 Answer: ${part1}`

  console.log(answer)

  return `Part 1 Answer: ${part1}`
}

function part2() {
  const part2 = parseDigits(/one|two|three|four|five|six|seven|eight|nine|\d/g)
  const answer = `Part 2 Answer: ${part2}`

  console.log(answer)

  return `Part 2 Answer: ${part2}`
}

part1()
part2()

module.exports = { part1, part2 }