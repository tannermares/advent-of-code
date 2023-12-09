#!/usr/bin/env node
const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  return input
    .map((row) => {
      const [_cardNumber, numbers] = row.split(': ')
      const [winningNumbers, myNumbers] = numbers
        .split(' | ')
        .map((n) => n.split(' '))
      const matches = myNumbers.filter(
        (n) => winningNumbers.includes(n) && n !== ''
      ).length

      if (matches > 0) {
        score = 1
        Array.from({ length: matches - 1 }).forEach(() => (score *= 2))
        return score
      } else {
        return 0
      }
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  const cards = Array.from({ length: input.length }).fill(0)

  input.forEach((row, index) => {
    const [_cardNumber, numbers] = row.split(': ')
    const [winningNumbers, myNumbers] = numbers
      .split(' | ')
      .map((n) => n.split(' '))
    const matches = myNumbers.filter(
      (n) => winningNumbers.includes(n) && n !== ''
    ).length
    cards[index] += 1

    Array.from({ length: cards[index] }).forEach(() => {
      Array.from({ length: matches }).forEach((_n, i) => {
        cards[index + i + 1] += 1
      })
    })
  })

  return cards.reduce((acc, n) => (acc += n))
}

module.exports = { part1, part2, SAMPLE }
