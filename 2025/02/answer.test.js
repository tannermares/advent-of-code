#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day02', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(part1(), 1_227_775_554)
      : assert.strictEqual(part1(), 53_420_042_388)
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(part2(), 4_174_379_265)
      : assert.strictEqual(part2(), 69_553_832_684)
  })
})
