#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day07', () => {
  test('part1', (t) => {
    return SAMPLE
      ? assert.strictEqual(part1(), 3_749)
      : assert.strictEqual(part1(), 882_304_362_421)
  })

  test('part2', (t) => {
    return SAMPLE
      ? assert.strictEqual(part2(), 11_387)
      : assert.strictEqual(part2(), 145_149_066_755_184)
  })
})
