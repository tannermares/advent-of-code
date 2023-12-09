#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const NORMAL_RANKS = {
  A: 14,
  K: 13,
  Q: 12,
  J: 11,
  T: 10,
  9: 9,
  8: 8,
  7: 7,
  6: 6,
  5: 5,
  4: 4,
  3: 3,
  2: 2,
}
const JOKER_RANKS = {
  A: 14,
  K: 13,
  Q: 12,
  T: 10,
  9: 9,
  8: 8,
  7: 7,
  6: 6,
  5: 5,
  4: 4,
  3: 3,
  2: 2,
  J: 1,
}

function typeHand(hand) {
  const sortedHand = [...hand].sort()

  if (sortedHand[0] === sortedHand[4]) {
    return 6
  } else if (
    sortedHand[0] === sortedHand[3] ||
    sortedHand[1] === sortedHand[4]
  ) {
    return 5
  } else if (
    (sortedHand[0] === sortedHand[2] && sortedHand[3] === sortedHand[4]) ||
    (sortedHand[0] === sortedHand[1] && sortedHand[2] === sortedHand[4])
  ) {
    return 4
  } else if (
    (sortedHand[0] === sortedHand[2] && sortedHand[3] !== sortedHand[4]) ||
    (sortedHand[0] !== sortedHand[1] && sortedHand[2] === sortedHand[4]) ||
    (sortedHand[0] !== sortedHand[1] &&
      sortedHand[1] === sortedHand[3] &&
      sortedHand[3] !== sortedHand[4])
  ) {
    return 3
  } else if (
    (sortedHand[0] === sortedHand[1] &&
      sortedHand[1] !== sortedHand[2] &&
      sortedHand[2] === sortedHand[3] &&
      sortedHand[3] !== sortedHand[4]) ||
    (sortedHand[0] !== sortedHand[1] &&
      sortedHand[1] === sortedHand[2] &&
      sortedHand[2] !== sortedHand[3] &&
      sortedHand[3] === sortedHand[4]) ||
    (sortedHand[0] === sortedHand[1] &&
      sortedHand[1] !== sortedHand[2] &&
      sortedHand[2] !== sortedHand[3] &&
      sortedHand[3] === sortedHand[4])
  ) {
    return 2
  } else if (
    (sortedHand[0] === sortedHand[1] &&
      sortedHand[1] !== sortedHand[2] &&
      sortedHand[2] !== sortedHand[3] &&
      sortedHand[3] !== sortedHand[4]) ||
    (sortedHand[0] !== sortedHand[1] &&
      sortedHand[1] === sortedHand[2] &&
      sortedHand[2] !== sortedHand[3] &&
      sortedHand[3] !== sortedHand[4]) ||
    (sortedHand[0] !== sortedHand[1] &&
      sortedHand[1] !== sortedHand[2] &&
      sortedHand[2] === sortedHand[3] &&
      sortedHand[3] !== sortedHand[4]) ||
    (sortedHand[0] !== sortedHand[1] &&
      sortedHand[1] !== sortedHand[2] &&
      sortedHand[2] !== sortedHand[3] &&
      sortedHand[3] === sortedHand[4])
  ) {
    return 1
  } else if (
    sortedHand[0] !== sortedHand[1] &&
    sortedHand[1] !== sortedHand[2] &&
    sortedHand[2] !== sortedHand[3] &&
    sortedHand[3] !== sortedHand[4]
  ) {
    return 0
  } else {
    throw new Error(`Invalid type for: ${sortedHand}`)
  }
}

function sortJsToBottom(a, b) {
  const aWild = a === 'J'
  const bWild = b === 'J'

  if (
    (!aWild && !bWild && a.charCodeAt(0) > b.charCodeAt(0)) ||
    (!aWild && bWild)
  ) {
    return -1
  } else if (
    (!aWild && !bWild && b.charCodeAt(0) > a.charCodeAt(0)) ||
    (aWild && !bWild)
  ) {
    return 1
  } else {
    return 0
  }
}

function typeHandWithJokers(hand) {
  // Sort Jokers to the bottom
  const sortedHand = [...hand].sort(sortJsToBottom)
  const numberOfJokers = sortedHand.filter((n) => n === 'J').length

  if (
    (sortedHand[0] == sortedHand[3] && numberOfJokers == 1) ||
    (sortedHand[0] == sortedHand[2] && numberOfJokers == 2) ||
    (sortedHand[0] == sortedHand[1] && numberOfJokers == 3) ||
    numberOfJokers == 4 ||
    numberOfJokers == 5
  ) {
    return 6
  } else if (
    (sortedHand[0] == sortedHand[2] &&
      numberOfJokers == 1 &&
      sortedHand[2] != sortedHand[3]) ||
    (sortedHand[0] != sortedHand[1] &&
      numberOfJokers == 1 &&
      sortedHand[1] == sortedHand[3]) ||
    (sortedHand[0] == sortedHand[1] &&
      numberOfJokers == 2 &&
      sortedHand[1] != sortedHand[2]) ||
    (sortedHand[0] != sortedHand[1] &&
      numberOfJokers == 2 &&
      sortedHand[1] == sortedHand[2]) ||
    (numberOfJokers == 3 && sortedHand[0] != sortedHand[1])
  ) {
    return 5
  } else if (
    sortedHand[0] == sortedHand[1] &&
    sortedHand[1] != sortedHand[2] &&
    sortedHand[2] == sortedHand[3] &&
    numberOfJokers == 1
  ) {
    return 4
  } else if (
    (sortedHand[0] == sortedHand[1] &&
      sortedHand[1] != sortedHand[2] &&
      sortedHand[2] != sortedHand[3] &&
      numberOfJokers == 1) ||
    (sortedHand[0] != sortedHand[1] &&
      sortedHand[1] == sortedHand[2] &&
      sortedHand[2] != sortedHand[3] &&
      numberOfJokers == 1) ||
    (sortedHand[0] != sortedHand[1] &&
      sortedHand[1] != sortedHand[2] &&
      sortedHand[2] == sortedHand[3] &&
      numberOfJokers == 1) ||
    (sortedHand[0] != sortedHand[1] &&
      sortedHand[1] != sortedHand[2] &&
      sortedHand[2] != sortedHand[3] &&
      numberOfJokers == 2)
  ) {
    return 3
  } else if (
    sortedHand[0] != sortedHand[1] &&
    sortedHand[1] != sortedHand[2] &&
    sortedHand[2] != sortedHand[3] &&
    sortedHand[3] != sortedHand[4] &&
    numberOfJokers == 1
  ) {
    return 1
  } else {
    throw new Error(`Invalid type for: ${sortedHand}`)
  }
}

function typeHands(handsWithScores, withWilds = false) {
  return handsWithScores.reduce((acc, handWithScore) => {
    let type

    if (withWilds && handWithScore[0].includes('J')) {
      type = typeHandWithJokers(handWithScore[0])
    } else {
      type = typeHand(handWithScore[0])
    }

    acc[type] ||= []
    acc[type].push(handWithScore)
    return acc
  }, [])
}

function sortHands(typedWithScores, ranks = NORMAL_RANKS) {
  return typedWithScores.map((typedHandsWithScores) => {
    if (typedHandsWithScores.length === 0) return

    return typedHandsWithScores.sort((a, b) => {
      firstDiffIndex = 0

      while (a[0][firstDiffIndex] === b[0][firstDiffIndex]) {
        firstDiffIndex += 1
      }

      if (ranks[a[0][firstDiffIndex]] > ranks[b[0][firstDiffIndex]]) {
        return 1
      } else if (ranks[b[0][firstDiffIndex]] > ranks[a[0][firstDiffIndex]]) {
        return -1
      } else {
        return 0
      }
    })
  })
}

function sumRanks(sortedTypedWithScores) {
  return sortedTypedWithScores
    .filter((n) => n !== null)
    .flat()
    .reduce(
      (acc, [_hand, score], rank) => (acc += parseInt(score) * (rank + 1)),
      0
    )
}

function part1() {
  handsWithScores = input.map((row) => row.split(' '))
  typedWithScores = typeHands(handsWithScores)
  sortedTypedWithScores = sortHands(typedWithScores)
  return sumRanks(sortedTypedWithScores)
}

function part2() {
  handsWithScores = input.map((row) => row.split(' '))
  typedWithScores = typeHands(handsWithScores, true)
  sortedTypedWithScores = sortHands(typedWithScores, JOKER_RANKS)
  return sumRanks(sortedTypedWithScores)
}

module.exports = { part1, part2, SAMPLE, typeHand, typeHandWithJokers }
