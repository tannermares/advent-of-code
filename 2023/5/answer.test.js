#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day5', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(35, part1())
      : assert.strictEqual(510_109_797, part1())
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(46, part2())
      : assert.strictEqual(9_622_622, part2())
  })
})