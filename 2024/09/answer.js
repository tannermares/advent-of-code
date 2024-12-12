#!/usr/bin/env node

const SAMPLE = false
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')

function part1() {
  const expandedDisk = []

  eachSlice(input[0]).forEach(([fileCount, freeSpace], fileId) => {
    const fileCountRange = Array.from({ length: fileCount })
    fileCountRange.forEach((_) => expandedDisk.push(fileId))

    const freeSpaceRange = Array.from({ length: freeSpace })
    freeSpaceRange.forEach((_) => expandedDisk.push('.'))
  })

  let emptySpacePointer = 0
  let compactPointer = expandedDisk.length - 1

  while (emptySpacePointer < compactPointer) {
    if (expandedDisk[emptySpacePointer] != '.') {
      emptySpacePointer += 1
    } else if (expandedDisk[compactPointer] == '.') {
      compactPointer -= 1
    } else {
      expandedDisk[emptySpacePointer] = expandedDisk[compactPointer]
      expandedDisk[compactPointer] = '.'
      emptySpacePointer += 1
      compactPointer -= 1
    }
  }

  return expandedDisk
    .filter((n) => n != '.')
    .map((n, index) => n * index)
    .reduce((acc, n) => (acc += n))
}

function part2() {
  const expandedDisk = []
  const freeSpaceMap = {}
  const fileMap = {}

  eachSlice(input[0]).forEach(([fileCount, freeSpace], fileId) => {
    const fileCountRange = Array.from({ length: fileCount })
    fileCountRange.forEach((_) => expandedDisk.push(fileId))
    fileMap[fileId] = {
      capacity: parseInt(fileCount),
      start: expandedDisk.length - fileCount,
    }

    const freeSpaceRange = Array.from({ length: freeSpace })
    freeSpaceRange.forEach((_) => expandedDisk.push('.'))

    if (freeSpace !== 0 && freeSpace !== undefined) {
      freeSpaceMap[freeSpace] ||= []
      freeSpaceMap[freeSpace].push(expandedDisk.length - freeSpace)
    }
  })

  let fileId = expandedDisk[expandedDisk.length - 1]
  while (fileId > -1) {
    const file = fileMap[fileId]
    const filteredObj = Object.fromEntries(
      Object.entries(freeSpaceMap).filter(([_, value]) => value.length != 0)
    )
    const availableFreeSpaces = Object.keys(filteredObj).sort()
    const possibleGaps = availableFreeSpaces.filter((fs) => fs >= file.capacity)

    let minGap
    let freeSpaceIndex = Infinity

    possibleGaps.forEach((pg) => {
      if (Math.min(...freeSpaceMap[pg]) < freeSpaceIndex) {
        minGap = pg
        freeSpaceIndex = Math.min(...freeSpaceMap[pg])
      }
    })

    if (freeSpaceMap[minGap] && freeSpaceMap[minGap][0] < file.start) {
      let freeSpaceStart = freeSpaceMap[minGap].shift()

      if (freeSpaceStart) {
        let freeSpaceEnd = freeSpaceStart + file.capacity
        const freeSpaceRange = Array.from(
          { length: freeSpaceEnd - freeSpaceStart },
          (_, i) => freeSpaceStart + i
        )

        freeSpaceRange.forEach((n, i) => {
          expandedDisk[n] = fileId
          expandedDisk[file.start + i] = '.'
        })

        const leftOverGap = minGap - file.capacity
        if (leftOverGap) {
          freeSpaceMap[leftOverGap] ||= []
          freeSpaceMap[leftOverGap].push(freeSpaceEnd)
          freeSpaceMap[leftOverGap] = freeSpaceMap[leftOverGap].sort(
            (a, b) => a - b
          )
        }
      }
    }

    fileId -= 1
  }

  return expandedDisk
    .map((n, index) => (n === '.' ? 0 : n * index))
    .reduce((acc, n) => (acc += n))
}

function eachSlice(array) {
  return array.split('').reduce((result, _, index, array) => {
    if (index % 2 === 0) result.push(array.slice(index, index + 2))
    return result
  }, [])
}

module.exports = { part1, part2, SAMPLE }
