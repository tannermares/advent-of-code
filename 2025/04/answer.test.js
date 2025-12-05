#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day04', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(part1(), 13)
      : assert.strictEqual(part1(), 1_518)
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(part2(), 43)
      : assert.strictEqual(part2(), 8_665)
  })
})
