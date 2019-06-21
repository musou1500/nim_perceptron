# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

import random, system, sequtils
from times import getTime, toUnix, nanosecond, now
import nim_perceptron / matrix as m
from sugar import `=>`

let now = getTime()
randomize(now.toUnix * 1000000000 + now.nanosecond)

type
  BaseIteration = ref object of RootObj
    weight: seq[int]
    okNum: int
    run: int

  Iteration = ref object of BaseIteration
    pocket: BaseIteration
    examples: seq[seq[int]]
    classifications: seq[int]

proc newIteration*(examples: seq[seq[int]], classifications: seq[int]): Iteration =
  if examples.len <= 0:
    raise newException(RangeError, "give >0 examples")

  if examples.len != classifications.len:
    raise newException(RangeError,
        "examples must have same length as classification")


  let initWeight = repeat(0, examples[0].len)
  let iteration = Iteration(
    weight: initWeight,
    okNum: 0,
    run: 0,
    examples: examples,
    classifications: classifications,
    pocket: BaseIteration(
      weight: initWeight,
      okNum: 0,
      run: 0
    )
  )

  return iteration

proc isCorrect(s: int, classification: int): bool =
  s > 0 and classification > 0 or s < 0 and classification < 0;

proc testWeight(weight: seq[int], example: seq[int],
    classification: int): bool =
  isCorrect(m.mult(weight, example), classification)

proc learn*(iteration: Iteration, maxIter = 999): seq[int] =
  var i = 0
  while i < maxIter:
    i.inc
    let example = iteration.examples.sample()
    let classification = iteration.classifications.sample()
    if testWeight(iteration.weight, example, classification):
      iteration.run.inc
      var okNum = 0
      for (e, c) in zip(iteration.examples, iteration.classifications):
        if testWeight(iteration.weight, e, c):
          okNum.inc
      iteration.okNum = okNum

      if iteration.okNum > iteration.pocket.okNum:
        iteration.pocket.okNum = iteration.okNum
        iteration.pocket.run = iteration.run
        iteration.pocket.weight = iteration.weight
        if iteration.okNum == iteration.examples.len:
          break
    else:
      iteration.okNum = 0
      iteration.weight = m.add(iteration.weight, m.mult(classification,
          example))
  return iteration.pocket.weight
