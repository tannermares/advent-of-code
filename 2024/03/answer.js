#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const part1Regex = /mul\((\d{1,3}),(\d{1,3})\)/g
const part2Regex = /(don't\(\)|do\(\)|mul\((\d{1,3}),(\d{1,3})\))/g

function part1() {
  return input
    .flatMap((row) =>
      [...row.matchAll(part1Regex)].map(
        ([_, first, second]) => parseInt(first) * parseInt(second)
      )
    )
    .reduce((acc, n) => (acc += n))
}

function part2() {
  let enabled = true

  return input
    .flatMap((row) =>
      [...row.matchAll(part2Regex)].map(([command, _, first, second]) => {
        if (command == 'do()') {
          enabled = true
          return 0
        }

        if (command == "don't()") {
          enabled = false
          return 0
        }

        return enabled ? parseInt(first) * parseInt(second) : 0
      })
    )
    .reduce((acc, n) => (acc += n))
}

module.exports = { part1, part2, SAMPLE }
