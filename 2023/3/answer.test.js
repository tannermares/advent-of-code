#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

test('part1', (t) => {
  SAMPLE
    ? assert.strictEqual(4_361, part1())
    : assert.strictEqual(532_331, part1())
})

test('part2', (t) => {
  SAMPLE
    ? assert.strictEqual(467_835, part2())
    : assert.strictEqual(82_301_120, part2())
})
