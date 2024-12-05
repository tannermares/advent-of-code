#!/usr/bin/env node

const SAMPLE = true
const path = require('path')
const fs = require('fs')
const input = fs
  .readFileSync(path.resolve(__dirname, SAMPLE ? 'sample.txt' : 'input.txt'))
  .toString()
  .split('\n')
const separatorIndex = input.findIndex((n) => n === '')
const rawRules = input.slice(0, separatorIndex)
const pageRows = input.slice(separatorIndex + 1, input.length)
let rules = {}

rawRules.forEach((rule) => {
  const [before, after] = rule.split('|')
  rules[before] ||= { before: [], after: [] }
  rules[after] ||= { before: [], after: [] }

  rules[before].before.push(after)
  rules[after].after.push(before)
})

function part1() {
  return pageRows
    .map((row) => {
      const pages = row.split(',')
      return correctOrder(pages)
        ? parseInt(pages[Math.floor(pages.length / 2)])
        : 0
    })
    .reduce((acc, n) => (acc += n))
}

function part2() {
  return input
    .map((row) => {
      const pages = row.split(',')
      const correct = correctOrder(pages)
      if (correct) return 0

      const fixedPages = fixPages(pages)
      return parseInt(fixedPages[Math.floor(fixedPages.length / 2)])
    })
    .reduce((acc, n) => (acc += n))
}

function validPage(pages, page, index) {
  if (index + 1 != pages.length && rules[page].after.includes(pages[index + 1]))
    return false
  if (index - 1 != -1 && rules[page].before.includes(pages[index - 1]))
    return false
  return true
}

function correctOrder(pages) {
  return pages.every((page, index) => validPage(pages, page, index))
}

function fixPages(pages) {
  const maybeFixedPages = [...pages]

  while (!correctOrder(maybeFixedPages)) {
    maybeFixedPages.map((page, index) => {
      if (validPage(maybeFixedPages, page, index)) return page

      if (rules[page].after.includes(maybeFixedPages[index + 1])) {
        const tempPage = maybeFixedPages[index + 1]
        maybeFixedPages[index + 1] = page
        maybeFixedPages[index] = tempPage
      }
    })
  }

  return maybeFixedPages
}

module.exports = { part1, part2, SAMPLE }
