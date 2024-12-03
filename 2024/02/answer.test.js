#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day2', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 2)
      : assert.strictEqual(part1(), 334)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 4)
      : assert.strictEqual(part2(), 400)
  })
})
