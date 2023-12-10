#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day1', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(209, part1())
      : assert.strictEqual(53_334, part1())
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(281, part2())
      : assert.strictEqual(52_834, part2())
  })
})
