#!/usr/bin/env node --test

const test = require('node:test')
const assert = require('assert')
const {
  part1,
  part2,
  SAMPLE,
  typeHand,
  typeHandWithJokers,
} = require('./answer.js')

test('typeHand', (t) => {
  // Five of a kind
  assert.strictEqual(6, typeHand('AAAAA'))

  // Four of a kind
  assert.strictEqual(5, typeHand('AAAAB'))
  assert.strictEqual(5, typeHand('ABBBB'))

  // Full House
  assert.strictEqual(4, typeHand('AAABB'))
  assert.strictEqual(4, typeHand('AABBB'))

  // Three of a kind
  assert.strictEqual(3, typeHand('AAABC'))
  assert.strictEqual(3, typeHand('ABCCC'))
  assert.strictEqual(3, typeHand('ABBBC'))

  // Two Pair
  assert.strictEqual(2, typeHand('AABBC'))
  assert.strictEqual(2, typeHand('ABBCC'))
  assert.strictEqual(2, typeHand('AABCC'))

  // One Pair
  assert.strictEqual(1, typeHand('AABCD'))
  assert.strictEqual(1, typeHand('ABBCD'))
  assert.strictEqual(1, typeHand('ABCCD'))
  assert.strictEqual(1, typeHand('ABCDD'))

  // High Card
  assert.strictEqual(0, typeHand('ABCDE'))
})

test('typeHandWithJokers', (t) => {
  // Five of a kind
  assert.strictEqual(6, typeHandWithJokers('AAAAJ'))
  assert.strictEqual(6, typeHandWithJokers('AAAJJ'))
  assert.strictEqual(6, typeHandWithJokers('AAJJJ'))
  assert.strictEqual(6, typeHandWithJokers('AJJJJ'))
  assert.strictEqual(6, typeHandWithJokers('JJJJJ'))

  // Four of a kind
  assert.strictEqual(5, typeHandWithJokers('AAABJ'))
  assert.strictEqual(5, typeHandWithJokers('ABBBJ'))
  assert.strictEqual(5, typeHandWithJokers('AABJJ'))
  assert.strictEqual(5, typeHandWithJokers('ABBJJ'))
  assert.strictEqual(5, typeHandWithJokers('ABJJJ'))

  // Full house
  assert.strictEqual(4, typeHandWithJokers('AABBJ'))

  // Three of a kind
  assert.strictEqual(3, typeHandWithJokers('AABCJ'))
  assert.strictEqual(3, typeHandWithJokers('ABCCJ'))
  assert.strictEqual(3, typeHandWithJokers('ABBCJ'))
  assert.strictEqual(3, typeHandWithJokers('ABCJJ'))

  // Two Pair
  // Not possible with a joker

  // One Pair
  assert.strictEqual(1, typeHandWithJokers('ABCDJ'))

  // High Card
  // Not possible with a joker
})

test('part1', (t) => {
  SAMPLE
    ? assert.strictEqual(6_440, part1())
    : assert.strictEqual(250_898_830, part1())
})

test('part2', (t) => {
  SAMPLE
    ? assert.strictEqual(5_905, part2())
    : assert.strictEqual(252_127_335, part2())
})
