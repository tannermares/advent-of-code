#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  const problems = []

  input.forEach((row) => {
    const nums = row.replace(/\s+/g, ' ').trim().split(' ')
    nums.forEach((n, i) => {
      problems[i] ||= []
      problems[i].push(n)
    })
  })

  return problems.reduce((acc, problem) => {
    const operator = problem.pop()
    const result = problem
      .map((n) => parseInt(n))
      .reduce((acc, n) => {
        acc = eval(`${acc}${operator}${n}`)
        return acc
      })

    acc += result
    return acc
  }, 0)
}

function part2() {
  let newInput = [...input]
  const operators = newInput.pop().replace(/\s+/g, '').split('').reverse()
  newInput = newInput.map((row) => row.split(''))

  const problems = transpose(newInput)
    .map((r) => r.join(''))
    .map((r) => r.trim())

  const sums = []
  let sum
  let problemPointer = 0

  for (let i = problems.length - 1; i >= 0; i--) {
    const num = problems[i]

    if (num.length === 0) {
      problemPointer += 1
      sums.push(sum)
      sum = null
      continue
    }

    if (!sum) {
      sum = parseInt(num)
      continue
    }

    sum = eval(`${sum}${operators[problemPointer]}${num}`)
  }

  sums.push(sum)
  return sums.reduce((acc, n) => (acc += n))
}

function transpose(array) {
  return array[0].map((_, colIndex) => array.map((row) => row[colIndex]))
}

module.exports = { part1, part2, SAMPLE }
