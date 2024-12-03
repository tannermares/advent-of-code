#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { buildSteps, part1, part2, SAMPLE } = require('./answer.js')

describe('day9', () => {
  test('buildSteps', () => {
    assert.deepEqual(
      [
        [0, 0, 0, 0],
        [3, 3, 3, 3, 3],
        [0, 3, 6, 9, 12, 15],
      ],
      buildSteps('0 3 6 9 12 15')
    )
  })

  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(114, part1())
      : assert.strictEqual(2_043_677_056, part1())
  })

  test('part2', () => {
    SAMPLE ? assert.strictEqual(2, part2()) : assert.strictEqual(1_062, part2())
  })
})