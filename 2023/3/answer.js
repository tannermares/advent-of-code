#!/usr/bin/env node

const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, 'input.txt'))
  .toString()
  .split('\n')
const digitRegex = /\d+/g
const symbolRegex = /[^.\d\s]/
const gearRegex = /\*/g

function part1() {
  return input
    .map((row, index) => {
      previousRow = index === 0 ? '' : input[index - 1]
      nextRow = input[index + 1] === undefined ? '' : input[index + 1]

      return [...row.matchAll(digitRegex)]
        .map((match) => {
          partNumber = match[0]
          partIndex = match.index
          partBufferStart = partIndex === 0 ? 0 : partIndex - 1
          previousAdjacent = previousRow.slice(
            partBufferStart,
            partIndex + partNumber.length + 1
          )
          currentAdjacent = row.slice(
            partBufferStart,
            partIndex + partNumber.length + 1
          )
          nextAdjacent = nextRow.slice(
            partBufferStart,
            partIndex + partNumber.length + 1
          )

          if (
            (previousAdjacent + currentAdjacent + nextAdjacent).search(
              symbolRegex
            ) >= 0
          ) {
            return parseInt(partNumber)
          } else {
            return 0
          }
        })
        .reduce((acc, n) => (acc += n), 0)
    })
    .reduce((acc, n) => (acc += n))
}

function findNumbersInRow(gears, row, gearIndex) {
  return [...row.matchAll(digitRegex)].forEach((match) => {
    partNumber = match[0]
    startOffset = match.index
    endOffset = match.index + match[0].length

    if (startOffset <= gearIndex + 1 && endOffset >= gearIndex) {
      gears.push(parseInt(partNumber))
    }
  })
}

function part2() {
  return input
    .map((row, index) => {
      gearIndexes = [...row.matchAll(gearRegex)].map((match) => match.index)
      previousRow = index === 0 ? '' : input[index - 1]
      nextRow = input[index + 1] === undefined ? '' : input[index + 1]

      return gearIndexes
        .map((gi) => {
          var gears = []

          findNumbersInRow(gears, previousRow, gi)
          findNumbersInRow(gears, row, gi)
          findNumbersInRow(gears, nextRow, gi)

          if (gears.length == 2) {
            return gears.reduce((acc, n) => (acc *= n))
          } else {
            return 0
          }
        })
        .reduce((acc, n) => (acc += n), 0)
    })
    .reduce((acc, n) => (acc += n))
}

console.log(`Part 1 Answer: ${part1()}`)
console.log(`Part 2 Answer: ${part2()}`)

module.exports = { part1, part2 }
