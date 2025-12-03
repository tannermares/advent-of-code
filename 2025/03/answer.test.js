#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day03', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(part1(), 357)
      : assert.strictEqual(part1(), 17_403)
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(part2(), 3_121_910_778_619)
      : assert.strictEqual(part2(), 173_416_889_848_394)
  })
})
