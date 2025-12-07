#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day06', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(part1(), 4_277_556)
      : assert.strictEqual(part1(), 6_725_216_329_103)
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(part2(), 3_263_827)
      : assert.strictEqual(part2(), 10_600_728_112_865)
  })
})
