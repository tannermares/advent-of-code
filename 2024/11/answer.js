#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const stones = input[0].split(' ').map((n) => parseInt(n))

function part1() {
  return blinkTimes(25)
}

function part2() {
  return blinkTimes(75)
}

function blinkTimes(number) {
  let newStones = {}
  stones.forEach((stone) => {
    newStones[stone] ||= 0
    newStones[stone] += 1
  })
  const blinkCache = {}

  const numberRange = Array.from({ length: number })
  numberRange.forEach((n) => {
    const nextStones = {}

    Object.entries(newStones).forEach(([stone, count]) => {
      const results = blink(stone, blinkCache)
      const alwaysArr = Array.isArray(results) ? results : [results]
      alwaysArr.forEach((result) => {
        nextStones[result] ||= 0
        nextStones[result] += count
      })
    })

    newStones = nextStones
  })

  return Object.values(newStones).reduce((acc, n) => (acc += n))
}

function blink(stone, cache) {
  if (cache[stone]) return cache[stone]

  let result

  if (stone === '0') {
    result = 1
  } else if (`${stone}`.length % 2 === 0) {
    const midPoint = `${stone}`.length / 2
    const first = parseInt(`${stone}`.slice(0, midPoint))
    const second = parseInt(`${stone}`.slice(midPoint))

    result = [first, second]
  } else {
    result = stone * 2024
  }

  cache[stone] = result
  return result
}

module.exports = { part1, part2, SAMPLE }
