#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  return input
    .map((row) => largestNumber(row.trim().split(''), 1))
    .reduce((acc, n) => (acc += n))
}

function part2() {
  return input
    .map((row) => largestNumber(row.trim().split(''), 11))
    .reduce((acc, n) => (acc += n))
}

function largestNumber(chars, digit) {
  const digits = []

  while (digit >= 0) {
    const index = chars.indexOf(`${digits[digits.length - 1]}`)
    if (index !== -1) chars = chars.slice(index + 1)

    digits.push(firstBiggest(chars, digit))
    digit = digit - 1
  }

  return parseInt(digits.join(''))
}

function firstBiggest(array, digit) {
  for (i = 9; i > 0; i--) {
    const index = array.indexOf(`${i}`)
    if (index === -1 || index >= array.length - digit) continue

    return i
  }
}

module.exports = { part1, part2, SAMPLE }
