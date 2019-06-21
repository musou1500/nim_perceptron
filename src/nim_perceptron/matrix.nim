import system, sequtils
from sugar import `=>`

proc add*(matA: seq[int], matB: seq[int]): seq[int] =
  if matA.len != matB.len:
    raise newException(RangeError, "matA.len != matB.len")
  return zip(matA, matB).map((p) => p[0] + p[1])


proc mult*(a: int, b: seq[int]): seq[int] = b.map(n => a * n)
proc mult*(matA: seq[int], matB: seq[int]): int =
  if matA.len != matB.len:
    raise newException(RangeError, "matA.len != matB.len")
  return zip(matA, matB).map((p) => p[0] * p[1]).foldl(a + b)

