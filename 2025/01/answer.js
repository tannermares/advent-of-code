#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  let currentPosition = 50

  return input
    .map((row) => {
      const direction = row.slice(0, 1)
      const rawAmount = row.slice(1)
      const amount =
        direction === 'R' ? parseInt(rawAmount) : -parseInt(rawAmount)
      const newPosition = currentPosition + amount
      currentPosition = newPosition % 100

      return currentPosition === 0 ? 1 : 0
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  let currentPosition = 50
  let zeros = 0

  input.map((row) => {
    const direction = row.slice(0, 1)
    const rawAmount = parseInt(row.slice(1))
    const amount = direction === 'R' ? 1 : -1

    new Array(rawAmount).fill(0).forEach((_) => {
      currentPosition = (currentPosition + amount) % 100
      if (currentPosition === 0) zeros = zeros + 1
    })
  })

  return zeros
}

module.exports = { part1, part2, SAMPLE }
