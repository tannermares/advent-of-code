#!/usr/bin/env node

const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const grid = input.map((row) => row.split(''))
const height = grid.length
const width = grid[0].length
const directions = [
  [0, -1],
  [1, 0],
  [0, 1],
  [-1, 0],
]

function part1() {
  const newGrid = deepClone(grid)
  let guardPosition = findGuard()
  let direction = 0

  while (validPosition(guardPosition)) {
    const nextPosition = guardPosition.map(
      (value, index) => value + directions[direction][index]
    )
    newGrid[guardPosition[1]][guardPosition[0]] = 'X'

    if (!validPosition(nextPosition)) break

    if (newGrid[nextPosition[1]][nextPosition[0]] === '#') {
      direction = (direction + 1) % 4
      guardPosition = guardPosition.map(
        (value, index) => value + directions[direction][index]
      )
    } else {
      guardPosition = nextPosition
    }
  }

  return newGrid.flat().filter((cell) => cell === 'X').length
}

function part2() {
  return Array.from(findPath())
    .slice(1)
    .map((potentialLoop) => (loops(JSON.parse(potentialLoop)) ? 1 : 0))
    .reduce((acc, n) => (acc += n))
}

function loops(potentialLoop) {
  let loopFound = false
  let loopDirection = 0
  let loopGrid = deepClone(grid)
  let loopPosition = findGuard()
  const visitedPositions = new Set()

  loopGrid[potentialLoop[1]][potentialLoop[0]] = 'O'

  while (validPosition(loopPosition)) {
    if (visitedPositions.has(JSON.stringify([loopPosition, loopDirection]))) {
      loopFound = true
      break
    } else {
      visitedPositions.add(JSON.stringify([loopPosition, loopDirection]))
    }

    let nextLoopPosition = loopPosition.map(
      (value, index) => value + directions[loopDirection][index]
    )
    if (!validPosition(nextLoopPosition)) break

    if (
      loopGrid[nextLoopPosition[1]][nextLoopPosition[0]] == '#' ||
      loopGrid[nextLoopPosition[1]][nextLoopPosition[0]] == 'O'
    ) {
      loopDirection = (loopDirection + 1) % 4
    } else {
      loopPosition = nextLoopPosition
    }
  }

  return loopFound
}

function findPath() {
  let guardPosition = findGuard()
  let direction = 0
  const visitedPositions = new Set()

  while (validPosition(guardPosition)) {
    visitedPositions.add(JSON.stringify(guardPosition))
    let nextPosition = guardPosition.map(
      (value, index) => value + directions[direction][index]
    )

    if (!validPosition(nextPosition)) break

    if (grid[nextPosition[1]][nextPosition[0]] == '#') {
      direction = (direction + 1) % 4
    } else {
      guardPosition = nextPosition
    }
  }

  return visitedPositions
}

function findGuard() {
  let guardPosition

  grid.forEach((row, i) =>
    row.forEach((cell, j) => {
      if (cell == '^') {
        guardPosition = [j, i]
        return
      }
    })
  )

  return guardPosition
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
