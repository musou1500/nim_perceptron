# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import nim_perceptron
test "answer is correct":
  let examples = @[
    @[1, 1, 1],
    @[1, 1, -1],
    @[1, -1, 1],
    @[1, -1, -1],
  ]
  let classifications = @[1, -1, -1, -1]
  let iteration = newIteration(examples, classifications)
  let weight = iteration.learn()
  check(weight == @[-1, 1, 1])
