#!/usr/bin/env node

const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  return findSolves(['+', '*'])
}

function part2() {
  return findSolves(['+', '*', '||'])
}

function findSolves(operators) {
  return input
    .map((row) => {
      let [result, nums] = row
        .split(': ')
        .map((n) => n.split(' '))
        .map((n) => n.map((m) => parseInt(m)))
      const combinations = repeatedPermutations(operators, nums.length - 1)
      result = result[0]

      const solvable = combinations.some((combination) => {
        const zipped = nums.map((num, index) => [num, combination[index]])
        const flattened = zipped.flat()
        const equation = flattened.filter((el) => el !== undefined)
        return result == solve(equation)
      })

      return solvable ? result : 0
    })
    .reduce((acc, n) => (acc += n))
}

function repeatedPermutations(array, length) {
  if (length === 1) return array.map((el) => [el])

  return array.flatMap((el) =>
    repeatedPermutations(array, length - 1).map((perm) => [el, ...perm])
  )
}

function solve(equation) {
  let result = equation[0]
  for (let i = 1; i < equation.length; i += 2) {
    const number = equation[i + 1]
    if (equation[i] === '+') {
      result += number
    } else if (equation[i] === '*') {
      result *= number
    } else {
      result = parseInt(`${result}` + `${number}`)
    }
  }

  return result
}

module.exports = { part1, part2, SAMPLE }
