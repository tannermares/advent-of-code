#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const grid = input.map((row) => row.split(''))
const height = grid.length

function part1() {
  const newGrid = deepClone(grid)
  let splittersUsed = 0

  for (let i = 0; i < newGrid.length; i++) {
    const row = newGrid[i]

    for (let j = 0; j < row.length; j++) {
      const cell = row[j]

      if (i === height - 1) break
      if (['.', '^'].includes(cell)) continue

      const cellBelow = newGrid[i + 1][j]

      if (cellBelow == '^') {
        splittersUsed += 1
        newGrid[i + 1][j - 1] = '|'
        newGrid[i + 1][j + 1] = '|'
      } else {
        newGrid[i + 1][j] = '|'
      }
    }
  }

  return splittersUsed
}

function part2() {
  const newGrid = deepClone(grid)
  let pathValues = new Proxy({}, defaultZeroHandler)
  let bottom = []

  for (let i = 0; i < newGrid.length; i++) {
    const row = newGrid[i]

    for (let j = 0; j < row.length; j++) {
      const cell = row[j]

      if (i === height - 1) break
      if (['.', '^'].includes(cell)) continue

      const cellBelow = newGrid[i + 1][j]
      const currentValue = pathValues[[j, i]]

      if (cellBelow == '^') {
        newGrid[i + 1][j - 1] = '|'
        newGrid[i + 1][j + 1] = '|'

        pathValues[[j - 1, i + 1]] += currentValue === 0 ? 1 : currentValue
        pathValues[[j + 1, i + 1]] += currentValue === 0 ? 1 : currentValue
      } else {
        newGrid[i + 1][j] = '|'
        pathValues[[j, i + 1]] += currentValue
      }

      if (i + 1 == height - 1) bottom.push(currentValue)
    }
  }

  return bottom.reduce((acc, n) => (acc += n))
}

let defaultZeroHandler = {
  get: function (target, name) {
    return target.hasOwnProperty(name) ? target[name] : 0
  },
}

function deepClone(arr) {
  return arr.map((row) => row.slice())
}

module.exports = { part1, part2, SAMPLE }
