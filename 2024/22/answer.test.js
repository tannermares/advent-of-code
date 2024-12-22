#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day22', () => {
  test('part1', (t) => {
    t.skip()
    return
    SAMPLE
      ? assert.strictEqual(part1(), null)
      : assert.strictEqual(part1(), null)
  })

  test('part2', (t) => {
    t.skip()
    return
    SAMPLE
      ? assert.strictEqual(part2(), null)
      : assert.strictEqual(part2(), null)
  })
})
