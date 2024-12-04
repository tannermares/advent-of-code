#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day3', () => {
  test('part1', () => {
    return SAMPLE
      ? assert.strictEqual(part1(), 161)
      : assert.strictEqual(part1(), 182_780_583)
  })

  test('part2', () => {
    return SAMPLE
      ? assert.strictEqual(part2(), 48)
      : assert.strictEqual(part2(), 90_772_405)
  })
})
