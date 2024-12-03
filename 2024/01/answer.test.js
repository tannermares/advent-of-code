#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day1', () => {
  test('part1', () =>
    SAMPLE
      ? assert.strictEqual(part1(), 11)
      : assert.strictEqual(part1(), 1765812))

  test('part2', () =>
    SAMPLE
      ? assert.strictEqual(part2(), 31)
      : assert.strictEqual(part2(), 20520794))
})
