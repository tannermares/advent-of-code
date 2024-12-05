#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day05', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 143)
      : assert.strictEqual(part1(), 6_267)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 123)
      : assert.strictEqual(part2(), 5_184)
  })
})
