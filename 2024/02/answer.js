#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  return input
    .map((row) => {
      const nums = row.split(' ').map((n) => parseInt(n))
      return levelSafe(nums) ? 1 : 0
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  return input
    .map((row) => {
      const nums = row.split(' ').map((n) => parseInt(n))
      if (levelSafe(nums)) return 1
      let indexToDrop = 0
      let eventuallySafe = false
      while (indexToDrop < nums.length) {
        newNums = nums.filter((_, index) => index != indexToDrop)
        indexToDrop += 1
        if (levelSafe(newNums)) {
          eventuallySafe = true
          break
        }
      }

      return eventuallySafe ? 1 : 0
    })
    .reduce((acc, n) => (acc += n))
}

function levelSafe(nums) {
  if (nums[0] == nums[nums.length - 1]) return false

  let prev = nums[0]
  const asc = nums[0] < nums[nums.length - 1]

  let safe = true
  for (let index = 1; index < nums.length; index++) {
    const n = nums[index]
    if (within_bounds(asc, prev, n)) {
      prev = n
      continue
    }

    safe = false
    break
  }
  return safe
}

function within_bounds(asc, prev, num) {
  if (asc) {
    return prev == num - 1 || prev == num - 2 || prev == num - 3
  } else {
    return prev == num + 1 || prev == num + 2 || prev == num + 3
  }
}

module.exports = { part1, part2, SAMPLE }
