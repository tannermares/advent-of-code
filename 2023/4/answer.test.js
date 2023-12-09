#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const { part1, part2, SAMPLE } = require('./answer.js')

test('part1', (t) => {
  SAMPLE ? assert.strictEqual(13, part1()) : assert.strictEqual(26_426, part1())
})

test('part2', (t) => {
  SAMPLE
    ? assert.strictEqual(30, part2())
    : assert.strictEqual(6_227_972, part2())
})
