#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day20', () => {
  test('part1', (t) => {
    t.skip()
    return
    SAMPLE
      ? assert.strictEqual(null, part1())
      : assert.strictEqual(null, part1())
  })

  test('part2', (t) => {
    t.skip()
    return
    SAMPLE
      ? assert.strictEqual(null, part2())
      : assert.strictEqual(null, part2())
  })
})
