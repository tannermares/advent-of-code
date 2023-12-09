#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { part1, part2 } = require('./answer.js')

test('part1', (t) => {
  assert.strictEqual(53334, part1())
})

test('part2', (t) => {
  assert.strictEqual(52834, part2())
})
