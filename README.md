# nim_perceptron

perceptron implementation by nim for learning purpose.
ported from [musou1500/learn-ml](https://github.com/musou1500/learn-ml)


```nim
import nim_perceptron

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
```
