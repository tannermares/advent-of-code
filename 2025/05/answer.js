#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  let fresh = 0
  const ranges = []

  input.forEach((row) => {
    if (row.includes('-')) {
      const [first, last] = row.split('-').map((n) => parseInt(n))
      ranges.push([first, last])
    } else {
      number = parseInt(row.trim())
      if (ranges.some(([f, l]) => number >= f && number <= l)) fresh += 1
    }
  })

  return fresh
}

function part2() {
  const ranges = []

  for (let i = 0; i < input.length; i++) {
    if (input[i].trim().length === 0) break

    const [first, last] = input[i].split('-').map((n) => parseInt(n))
    ranges.push([first, last])
  }

  const newRanges = mergeOverlappingRanges(ranges)
  return newRanges.reduce((acc, [f, l]) => (acc += l + 1 - f), 0)
}

function mergeOverlappingRanges(ranges) {
  const newRanges = ranges.sort((a, b) => a[0] - b[0])
  let merged = [newRanges.shift()]

  newRanges.forEach((current) => {
    const lastMerged = merged[merged.length - 1]

    if (lastMerged[1] >= current[0]) {
      lastMerged[1] = Math.max(...[lastMerged[1], current[1]])
    } else {
      merged.push(current)
    }
  })

  return merged
}

module.exports = { part1, part2, SAMPLE }
