#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day10', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 36)
      : assert.strictEqual(part1(), 510)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 81)
      : assert.strictEqual(part2(), 1058)
  })
})
