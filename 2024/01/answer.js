#!/usr/bin/env node

const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  const [leftList, rightList] = buildLists()
  const pairedLists = leftList.map((n, i) => [n, rightList[i]])

  let difference = 0
  pairedLists.forEach((pair) => {
    difference += Math.abs(pair[0] - pair[1])
  })

  return difference
}

function part2() {
  const [leftList, rightList] = buildLists()
  return leftList.reduce((acc, n) => (acc += n * countNums(rightList, n)), 0)
}

function countNums(list, n) {
  let count = 0
  list.forEach((m) => m === n && count++)
  return count
}

function buildLists() {
  let leftList = []
  let rightList = []

  input.forEach((row) => {
    const [left, right] = row.split('   ').map((n) => parseInt(n))
    leftList.push(left)
    rightList.push(right)
  })

  leftList = leftList.sort()
  rightList = rightList.sort()

  return [leftList, rightList]
}

module.exports = { part1, part2, SAMPLE }
