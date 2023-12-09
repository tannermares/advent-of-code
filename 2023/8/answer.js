#!/usr/bin/env node

const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

// Shamelessly stolen from
// https://www.geeksforgeeks.org/javascript-program-to-find-lcm-of-two-numbers/
function lcm(a, b) {
  function gcd(a, b) {
    for (let temp = b; b !== 0; ) {
      b = a % b
      a = temp
      temp = b
    }
    return a
  }

  const gcdValue = gcd(a, b)
  return (a * b) / gcdValue
}

function parseInput() {
  let instructions
  const nodes = {}

  input.forEach((row, index) => {
    if (index === 0) {
      instructions = row
      return
    }

    if (row === '') return

    const [start, nextStep] = row.split(' = ')
    nodes[start] = nextStep.replace(/\(|\)/g, '').split(', ')
  })

  return [instructions, nodes]
}

function part1() {
  let steps = 0
  let currentNode = 'AAA'
  const [instructions, nodes] = parseInput()

  while (currentNode !== 'ZZZ') {
    ;[...instructions].forEach((inst) => {
      steps += 1
      currentNode = inst == 'L' ? nodes[currentNode][0] : nodes[currentNode][1]
    })
  }

  return steps
}

function part2() {
  let steps = 0
  const zCounts = []
  const [instructions, nodes] = parseInput()
  const currentNodes = Object.keys(nodes).filter((node) => node.endsWith('A'))

  while (true) {
    ;[...instructions].forEach((inst) => {
      steps += 1

      currentNodes.forEach((node, index) => {
        if (node.endsWith('Z')) return

        const nextNode = inst == 'L' ? nodes[node][0] : nodes[node][1]

        if (nextNode.endsWith('Z')) zCounts.push(steps)
        currentNodes[index] = nextNode
      })
    })

    if (currentNodes.every((node) => node.endsWith('Z'))) break
  }

  return zCounts.reduce((acc, zCount) => lcm(zCount, acc), 1)
}

module.exports = { part1, part2, SAMPLE }
