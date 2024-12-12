#!/usr/bin/env node

const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const grid = input.map((row) => row.split('').map((cell) => parseInt(cell)))
const height = grid.length
const width = grid[0].length
const directions = [
  [0, -1],
  [1, 0],
  [0, 1],
  [-1, 0],
]

function part1() {
  let score = 0

  grid.forEach((row, i) => {
    row.forEach((cell, j) => {
      if (cell === 0) {
        score += walkTrail(0, [j, i], Set).size
      }
    })
  })

  return score
}

function part2() {
  let score = 0

  grid.forEach((row, i) => {
    row.forEach((cell, j) => {
      if (cell === 0) {
        score += walkTrail(0, [j, i], Array).length
      }
    })
  })

  return score
}

function walkTrail(number, position, collection) {
  let summits = new collection()
  let newDirections = [...directions]

  while (newDirections.length > 0) {
    let direction = newDirections.shift()
    let nextPosition = position.map((pos, index) => pos + direction[index])
    if (!validPosition(nextPosition)) continue

    let nextNumber = grid[nextPosition[1]][nextPosition[0]]
    if (nextNumber !== number + 1) continue

    if (nextNumber === 9) {
      if (Array.isArray(summits)) {
        summits.push(nextPosition)
      } else {
        summits.add(JSON.stringify(nextPosition))
      }
    } else {
      if (Array.isArray(summits)) {
        summits = [
          ...summits,
          ...walkTrail(nextNumber, nextPosition, collection),
        ]
      } else {
        summits = new collection([
          ...summits,
          ...walkTrail(nextNumber, nextPosition, collection),
        ])
      }
    }
  }

  return summits
}

function validPosition(position) {
  return (
    position[0] >= 0 &&
    position[0] <= width - 1 &&
    position[1] >= 0 &&
    position[1] <= height - 1
  )
}

module.exports = { part1, part2, SAMPLE }
