#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day05', () => {
  test('part1', () => {
    SAMPLE ? assert.strictEqual(part1(), 3) : assert.strictEqual(part1(), 770)
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(part2(), 14)
      : assert.strictEqual(part2(), 357_674_099_117_260)
  })
})
