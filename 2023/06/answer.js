#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function distancesTraveled(time, distance) {
  const buttonHoldingRange = Array.from({ length: time }, (_, n) => n)

  return buttonHoldingRange
    .map((bhTime) => {
      duration = time - bhTime
      dist = bhTime * duration

      return dist > distance
    })
    .filter((n) => n).length
}

function part1() {
  const times = input[0].match(/\d+/g).map((n) => parseInt(n))
  const distances = input[1].match(/\d+/g).map((n) => parseInt(n))

  return times
    .map((time, index) => {
      return distancesTraveled(time, distances[index])
    })
    .reduce((acc, n) => (acc *= n))
}

function part2() {
  const time = parseInt(input[0].match(/\d+/g).join(''))
  const distance = parseInt(input[1].match(/\d+/g).join(''))

  return distancesTraveled(time, distance)
}

module.exports = { part1, part2, SAMPLE }
