#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day8', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(2, part1())
      : assert.strictEqual(13_301, part1())
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(6, part2())
      : assert.strictEqual(7_309_459_565_207, part2())
  })
})