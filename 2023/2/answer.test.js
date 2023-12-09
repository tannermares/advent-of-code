#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

test('part1', (t) => {
  SAMPLE ? assert.strictEqual(8, part1()) : assert.strictEqual(1_867, part1())
})

test('part2', (t) => {
  SAMPLE
    ? assert.strictEqual(2_286, part2())
    : assert.strictEqual(84_538, part2())
})
