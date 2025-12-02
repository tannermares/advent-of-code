#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  return input[0]
    .split(',')
    .map((row) => {
      let invalid = []
      const [low, high] = row.split('-').map((n) => parseInt(n))
      const range = Array.from({ length: high - low + 1 }, (_, i) => low + i)

      range.forEach((n) => {
        const nString = `${n}`
        const length = nString.length

        mid = length / 2
        first = nString.slice(0, mid)
        second = nString.slice(mid)

        if (first == second) invalid.push(n)
      })

      return invalid.length > 0 ? invalid.reduce((acc, n) => (acc += n)) : 0
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  return input[0]
    .split(',')
    .map((row) => {
      let invalid = []
      const [low, high] = row.split('-').map((n) => parseInt(n))
      const range = Array.from({ length: high - low + 1 }, (_, i) => low + i)

      range.forEach((n) => {
        const nString = `${n}`
        const length = nString.length

        mid = Math.floor(length / 2)
        first = nString.slice(0, mid)
        second = nString.slice(mid)

        for (let i = mid; i > 0; i -= 1) {
          let chunks = []

          for (let j = 0; j < nString.length; j += i) {
            const chunk = nString.slice(j, j + i)
            chunks.push(chunk)
          }

          let unique = [...new Set(chunks)]

          if (unique.length == 1) {
            invalid.push(n)
            break
          }
        }
      })

      return invalid.length > 0 ? invalid.reduce((acc, n) => (acc += n)) : 0
    })
    .reduce((acc, n) => (acc += n))
}

module.exports = { part1, part2, SAMPLE }
