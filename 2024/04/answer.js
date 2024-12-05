#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const grid = input.map((row) => row.split(''))

function part1() {
  return input
    .map((row, i) => {
      found = 0

      for (let j = 0; j < row.length; j++) {
        const cell = row[j]
        if (cell !== 'X') continue

        if (checkNorth(i, j)) found++
        if (checkNorthEast(i, j)) found++
        if (checkEast(i, j)) found++
        if (checkSouthEast(i, j)) found++
        if (checkSouth(i, j)) found++
        if (checkSouthWest(i, j)) found++
        if (checkWest(i, j)) found++
        if (checkNorthWest(i, j)) found++
      }

      return found
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  return input
    .map((row, i) => {
      found = 0

      for (let j = 0; j < row.length; j++) {
        const cell = row[j]
        if (cell !== 'A') continue
        if (
          !(validNorth2(i) && validSouth2(i) && validEast2(j) && validWest2(j))
        )
          continue

        if (checkNorthEast2(i, j) && checkSouthEast2(i, j)) found++
        if (checkNorthWest2(i, j) && checkSouthWest2(i, j)) found++
        if (checkSouthWest2(i, j) && checkSouthEast2(i, j)) found++
        if (checkNorthWest2(i, j) && checkNorthEast2(i, j)) found++
      }

      return found
    })
    .reduce((acc, n) => (acc += n))
}

function validNorth(i) {
  return i - 1 != -1 && i - 2 != -1 && i - 3 != -1
}

function validEast(j) {
  return (
    j + 1 != grid[0].length &&
    j + 2 != grid[0].length &&
    j + 3 != grid[0].length
  )
}

function validSouth(i) {
  return i + 1 != grid.length && i + 2 != grid.length && i + 3 != grid.length
}

function validWest(j) {
  return j - 1 != -1 && j - 2 != -1 && j - 3 != -1
}

function checkNorth(i, j) {
  if (!validNorth(i)) return false

  return grid[i - 1][j] == 'M' && grid[i - 2][j] == 'A' && grid[i - 3][j] == 'S'
}

function checkNorthEast(i, j) {
  if (!(validNorth(i) && validEast(j))) return false

  return (
    grid[i - 1][j + 1] == 'M' &&
    grid[i - 2][j + 2] == 'A' &&
    grid[i - 3][j + 3] == 'S'
  )
}

function checkEast(i, j) {
  if (!validEast(j)) return false

  return grid[i][j + 1] == 'M' && grid[i][j + 2] == 'A' && grid[i][j + 3] == 'S'
}

function checkSouthEast(i, j) {
  if (!(validSouth(i) && validEast(j))) return false

  return (
    grid[i + 1][j + 1] == 'M' &&
    grid[i + 2][j + 2] == 'A' &&
    grid[i + 3][j + 3] == 'S'
  )
}

function checkSouth(i, j) {
  if (!validSouth(i)) return false

  return grid[i + 1][j] == 'M' && grid[i + 2][j] == 'A' && grid[i + 3][j] == 'S'
}

function checkSouthWest(i, j) {
  if (!(validSouth(i) && validWest(j))) return false

  return (
    grid[i + 1][j - 1] == 'M' &&
    grid[i + 2][j - 2] == 'A' &&
    grid[i + 3][j - 3] == 'S'
  )
}

function checkWest(i, j) {
  if (!validWest(j)) return false

  return grid[i][j - 1] == 'M' && grid[i][j - 2] == 'A' && grid[i][j - 3] == 'S'
}

function checkNorthWest(i, j) {
  if (!(validNorth(i) && validWest(j))) return false

  return (
    grid[i - 1][j - 1] == 'M' &&
    grid[i - 2][j - 2] == 'A' &&
    grid[i - 3][j - 3] == 'S'
  )
}

function validNorth2(i) {
  return i - 1 != -1
}

function validEast2(j) {
  return j + 1 != grid[0].length
}

function validSouth2(i) {
  return i + 1 != grid.length
}

function validWest2(j) {
  return j - 1 != -1
}

function checkNorthEast2(i, j) {
  return grid[i - 1][j + 1] == 'M' && grid[i + 1][j - 1] == 'S'
}

function checkSouthEast2(i, j) {
  return grid[i + 1][j + 1] == 'M' && grid[i - 1][j - 1] == 'S'
}

function checkSouthWest2(i, j) {
  return grid[i + 1][j - 1] == 'M' && grid[i - 1][j + 1] == 'S'
}

function checkNorthWest2(i, j) {
  return grid[i - 1][j - 1] == 'M' && grid[i + 1][j + 1] == 'S'
}

module.exports = { part1, part2, SAMPLE }
