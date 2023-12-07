#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { part1, part2 } = require('./answer.js')

test('part 1', (t) => {
  assert.strictEqual(1867, part1())
})

test('part 2', (t) => {
  assert.strictEqual(84538, part2())
})