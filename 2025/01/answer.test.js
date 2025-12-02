#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day01', () => {
  test('part1', () => {
    SAMPLE ? assert.strictEqual(part1(), 3) : assert.strictEqual(part1(), 982)
  })

  test('part2', (t) => {
    SAMPLE ? assert.strictEqual(part2(), 6) : assert.strictEqual(part2(), 6106)
  })
})
