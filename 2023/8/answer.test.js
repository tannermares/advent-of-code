#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { SAMPLE, part1, part2 } = require('./answer.js')

test('part 1', (t) => {
  SAMPLE ? assert.strictEqual(2, part1()) : assert.strictEqual(13_301, part1())
})

test('part 2', (t) => {
  SAMPLE
    ? assert.strictEqual(6, part2())
    : assert.strictEqual(7_309_459_565_207, part2())
})
