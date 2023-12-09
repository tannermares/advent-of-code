#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

test('part1', (t) => {
  SAMPLE
    ? assert.strictEqual(209, part1())
    : assert.strictEqual(53_334, part1())
})

test('part2', (t) => {
  SAMPLE
    ? assert.strictEqual(281, part2())
    : assert.strictEqual(52_834, part2())
})
