#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

test('part1', (t) => {
  SAMPLE
    ? assert.strictEqual(35, part1())
    : assert.strictEqual(510_109_797, part1())
})

test('part2', (t) => {
  SAMPLE
    ? assert.strictEqual(46, part2())
    : assert.strictEqual(9_622_622, part2())
})
