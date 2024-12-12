#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  let seeds
  const maps = []
  let currentMap = -1

  input.forEach((row) => {
    if (row.includes('seeds')) {
      seeds = row
        .split(': ')[1]
        .split(' ')
        .map((n) => parseInt(n))
      return
    }

    if (row.includes('map:')) {
      currentMap += 1
      return
    }

    if (row.length === 0) return
    const [dest, source, length] = row.split(' ')

    maps[currentMap] ||= { destinations: [], lengths: [], sources: [] }
    maps[currentMap]['destinations'].push(parseInt(dest))
    maps[currentMap]['sources'].push(parseInt(source))
    maps[currentMap]['lengths'].push(parseInt(length))
  })

  return seeds
    .map((seed) =>
      maps.reduce((acc, map) => {
        map['sources'].every((source, index) => {
          if (acc >= source && acc <= source + map['lengths'][index]) {
            acc += map['destinations'][index] - source
            return false
          }
          return true
        })

        return acc
      }, seed)
    )
    .sort((a, b) => a - b)[0]
}

function adjustRange(adjustment, range) {
  if (range[0] > adjustment[1] || range[1] < adjustment[0] || range[2])
    return [range]

  let low = range[0]
  let high = range[1]
  const newRanges = []

  if (range[0] < adjustment[0]) {
    const rangeEnd = Math.min(adjustment[0] - 1, range[1])
    newRanges.push([range[0], rangeEnd])
    low = rangeEnd + 1
  }

  if (range[1] > adjustment[1]) {
    const rangeStart = Math.max(range[0], adjustment[1] + 1)
    newRanges.push([rangeStart, range[1]])
    high = rangeStart - 1
  }

  newStart = Math.max(low, adjustment[0]) + adjustment[2]
  newEnd = Math.min(high, adjustment[1]) + adjustment[2]
  newRanges.push([newStart, newEnd, true])

  return newRanges
}

function part2() {
  let seeds
  const maps = []
  const ranges = []
  let currentMap = -1

  input.forEach((row) => {
    if (row.includes('seeds')) {
      seeds = row
        .split(': ')[1]
        .split(' ')
        .map((n) => parseInt(n))
      return
    }

    if (row.includes('map:')) {
      currentMap += 1
      return
    }

    if (row.length === 0) return
    const [dest, source, length] = row.split(' ').map((n) => parseInt(n))

    maps[currentMap] ||= []
    maps[currentMap].push([source, source + length - 1, dest - source])
  })

  seeds.forEach((seed, index) => {
    if (index % 2 === 0) ranges.push([seed, seed + seeds[index + 1] - 1])
  })

  return maps
    .reduce((acc, adjustments) => {
      const flattened = adjustments.reduce(
        (accu, adjustment) =>
          accu.flatMap((range) => adjustRange(adjustment, range)),
        acc
      )

      return flattened.map((r) => {
        r[2] = false
        return r
      })
    }, ranges)
    .map((i) => i[0])
    .sort((a, b) => a - b)[0]
}

module.exports = { part1, part2, SAMPLE }
