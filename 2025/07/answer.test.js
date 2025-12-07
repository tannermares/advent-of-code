#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day07', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(part1(), 21)
      : assert.strictEqual(part1(), 1_581)
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(part2(), 40)
      : assert.strictEqual(part2(), 73_007_003_089_792)
  })
})
