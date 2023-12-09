#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function buildSteps(row) {
  const steps = [row.split(' ').map((n) => parseInt(n))]

  while (true) {
    lastStep = steps[steps.length - 1]
    nextStep = lastStep
      .map((n, i) => (i + 1 < lastStep.length ? lastStep[i + 1] - n : null))
      .filter((n) => n !== null)
    steps.push(nextStep)

    if (steps[steps.length - 1].every((n) => n === 0)) break
  }

  return steps.reverse()
}

function part1() {
  return input
    .map((row) => {
      const answers = []
      const steps = buildSteps(row)

      steps.forEach((step, i) => {
        let previousRow

        step.push(0)
        if (i !== 0) previousRow = steps[i - 1]

        change = previousRow
          ? step[step.length - 2] + previousRow[previousRow.length - 1]
          : 0
        step[step.length - 1] = change

        if (i === steps.length - 1) {
          answers.push(change)
        }
      })

      return answers.reduce((acc, n) => (acc += n))
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  return input
    .map((row) => {
      const answers = []
      const steps = buildSteps(row)

      steps.forEach((step, i) => {
        let previousRow

        step.unshift(0)
        if (i !== 0) previousRow = steps[i - 1]

        change = previousRow ? step[1] - previousRow[0] : 0
        step[0] = change

        if (i === steps.length - 1) {
          answers.push(change)
        }
      })

      return answers.reduce((acc, n) => (acc += n))
    })
    .reduce((acc, n) => (acc += n))
}

module.exports = { buildSteps, part1, part2, SAMPLE }
