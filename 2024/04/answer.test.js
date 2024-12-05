#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day04', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 18)
      : assert.strictEqual(part1(), 2_447)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 9)
      : assert.strictEqual(part2(), 1_868)
  })
})
