#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day08', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 14)
      : assert.strictEqual(part1(), 348)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 34)
      : assert.strictEqual(part2(), 1_221)
  })
})
