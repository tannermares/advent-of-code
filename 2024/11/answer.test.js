#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day11', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 55_312)
      : assert.strictEqual(part1(), 183_620)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 65_601_038_650_482)
      : assert.strictEqual(part2(), 220_377_651_399_268)
  })
})
