#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day09', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 1_928)
      : assert.strictEqual(part1(), 6_242_766_523_059)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 2_858)
      : assert.strictEqual(part2(), 6_272_188_244_509)
  })
})
