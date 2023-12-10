#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day6', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(288, part1())
      : assert.strictEqual(800_280, part1())
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(71_503, part2())
      : assert.strictEqual(45_128_024, part2())
  })
})