#!/usr/bin/env node --test

const { describe, test } = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

describe('day4', () => {
  test('part1', () => {
    SAMPLE
      ? assert.strictEqual(13, part1())
      : assert.strictEqual(26_426, part1())
  })

  test('part2', () => {
    SAMPLE
      ? assert.strictEqual(30, part2())
      : assert.strictEqual(6_227_972, part2())
  })
})