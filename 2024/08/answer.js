#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const grid = input.map((row) => row.split(''))
const height = grid.length
const width = grid[0].length

function part1() {
  return findAntinodes({ findResonantHarmonics: false })
}

function part2() {
  return findAntinodes({ findResonantHarmonics: true })
}

function findAntinodes({ findResonantHarmonics }) {
  const frequencies = {}
  const antinodes = new Set()

  grid.forEach((row, i) => {
    row.forEach((cell, j) => {
      if (cell != '.') {
        frequencies[cell] ||= { coords: [], pairs: [], antinodes: [] }
        frequencies[cell].coords.push([j, i])
      }
    })
  })

  Object.values(frequencies).forEach((node) => {
    node.pairs = combination(node.coords)
    node.pairs.forEach((pair) => {
      const newAntinodes = findAntinodesForPair(
        pair[0],
        pair[1],
        findResonantHarmonics
      )
      node.antinodes += newAntinodes
      newAntinodes.forEach((an) => antinodes.add(JSON.stringify(an)))
    })
  })

  return Array.from(antinodes).filter((a) => validAntinode(JSON.parse(a)))
    .length
}

function findAntinodesForPair(node, otherNode, findResonantHarmonics = false) {
  const [x1, y1] = node
  const [x2, y2] = otherNode

  // Get slope
  const dx = x2 - x1
  const dy = y2 - y1

  let newStart = [x1 - dx, y1 - dy]
  let newEnd = [x2 + dx, y2 + dy]
  let antinodes = [newStart, newEnd]

  if (findResonantHarmonics) {
    antinodes = antinodes.concat([node, otherNode])

    while (validAntinode(newStart) || validAntinode(newEnd)) {
      newStart = [newStart[0] - dx, newStart[1] - dy]
      newEnd = [newEnd[0] + dx, newEnd[1] + dy]
      antinodes = antinodes.concat([newStart, newEnd])
    }
  }

  return antinodes
}

function combination(array) {
  return array.flatMap((n, i) => array.slice(i + 1).map((m) => [n, m]))
}

function validAntinode(antinode) {
  return (
    antinode[0] >= 0 &&
    antinode[0] <= width - 1 &&
    antinode[1] >= 0 &&
    antinode[1] <= height - 1
  )
}

module.exports = { part1, part2, SAMPLE }
