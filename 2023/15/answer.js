#!/usr/bin/env node

const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  return input.map((row) => {}).reduce((acc, n) => (acc += n))
}

function part2() {
  return input.map((row) => {}).reduce((acc, n) => (acc += n))
}

module.exports = { part1, part2, SAMPLE }
