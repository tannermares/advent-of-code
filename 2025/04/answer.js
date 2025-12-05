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
const width = grid[0].length
const fullDirections = [
  [-1, -1],
  [0, -1],
  [1, -1],
  [-1, 0],
  [1, 0],
  [-1, 1],
  [0, 1],
  [1, 1],
]

function part1() {
  let accessibleRolls = 0

  for (let i = 0; i < grid.length; i++) {
    const row = grid[i]

    for (let j = 0; j < row.length; j++) {
      const cell = row[j]

      if (cell !== '@') continue

      let adjacentRolls = 0

      for (let k = 0; k < fullDirections.length; k++) {
        const direction = fullDirections[k]
        const nextPosition = zip([j, i], direction).map((pos) =>
          pos.reduce((acc, n) => (acc += n))
        )
        if (!validPosition(nextPosition)) continue

        const nextCell = grid[nextPosition[1]][nextPosition[0]]
        if (nextCell !== '@') continue

        adjacentRolls += 1
        if (adjacentRolls === 4) break
      }

      if (adjacentRolls < 4) accessibleRolls += 1
    }
  }

  return accessibleRolls
}

function part2() {
  let newGrid = deepClone(grid)
  let accessibleRolls = 0
  let rollsToRemove

  do {
    rollsToRemove = []

    for (let i = 0; i < newGrid.length; i++) {
      const row = newGrid[i]

      for (let j = 0; j < row.length; j++) {
        const cell = row[j]

        if (cell !== '@') continue

        let adjacentRolls = 0

        for (let k = 0; k < fullDirections.length; k++) {
          const direction = fullDirections[k]
          const nextPosition = zip([j, i], direction).map((pos) =>
            pos.reduce((acc, n) => (acc += n))
          )
          if (!validPosition(nextPosition)) continue

          const nextCell = newGrid[nextPosition[1]][nextPosition[0]]
          if (nextCell !== '@') continue

          adjacentRolls += 1
          if (adjacentRolls === 4) break
        }

        if (adjacentRolls < 4) {
          rollsToRemove.push([j, i])
          accessibleRolls += 1
        }
      }
    }

    rollsToRemove.forEach((position) => {
      newGrid[position[1]][position[0]] = '.'
    })
  } while (rollsToRemove.length > 0)

  return accessibleRolls
}

function zip(a, b) {
  return a.map((e, i) => [e, b[i]])
}

function validPosition(position) {
  return (
    position[0] >= 0 &&
    position[0] <= width - 1 &&
    position[1] >= 0 &&
    position[1] <= height - 1
  )
}

function deepClone(arr) {
  return arr.map((row) => row.slice())
}

module.exports = { part1, part2, SAMPLE }
