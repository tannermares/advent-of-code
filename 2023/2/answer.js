#!/usr/bin/env node

const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, './input.txt'))
  .toString()
  .split('\n')
const maxCubes = { blue: 14, green: 13, red: 12 }

const part1 = input
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
  .reduce((n, acc) => (acc += n))

const part2 = input
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

    return Object.values(gameMins).reduce((n, acc) => (acc *= n))
  })
  .reduce((n, acc) => (acc += n))

console.log(`Part 1 Answer: ${part1}`)
console.log(`Part 2 Answer: ${part2}`)
