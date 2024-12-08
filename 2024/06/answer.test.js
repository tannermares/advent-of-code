#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day06', () => {
  test('part1', (t) => {
    SAMPLE
      ? assert.strictEqual(part1(), 41)
      : assert.strictEqual(part1(), 5_404)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 6)
      : assert.strictEqual(part2(), 1_984)
  })
})
