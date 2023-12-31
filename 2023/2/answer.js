#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const maxCubes = { blue: 14, green: 13, red: 12 }

function part1() {
  return input
    .map((row) => {
      const [title, game] = row.split(': ')
      const [_, gameId] = title.split(' ')
      const sets = game.split('; ')

      const invalidGame = sets.some((set) => {
        const cubes = set.split(', ')

        return cubes.some((cube) => {
          const [pulled, color] = cube.split(' ')

          return parseInt(pulled) > maxCubes[color]
        })
      })

      return invalidGame ? 0 : parseInt(gameId)
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  return input
    .map((row) => {
      const [_, game] = row.split(': ')
      const sets = game.split('; ')
      let gameMins = { blue: 0, green: 0, red: 0 }

      sets.forEach((set) => {
        const cubes = set.split(', ')

        cubes.forEach((cube) => {
          const [pulled, color] = cube.split(' ')

          if (gameMins[color] <= parseInt(pulled))
            gameMins[color] = parseInt(pulled)
        })
      })

      return Object.values(gameMins).reduce((acc, n) => (acc *= n))
    })
    .reduce((acc, n) => (acc += n))
}

module.exports = { part1, part2, SAMPLE }
