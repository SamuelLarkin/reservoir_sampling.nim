# vim:sw=2:ts=2
# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
# [Nim by Example](https://nim-by-example.github.io/for_iterators/)

import std/enumerate
import std/heapqueue
#import std/json
import std/random
import std/sugar

from std/times import getTime, nanosecond
from system/io import stdin



proc r(sampleSize: int = 3): seq[string] =
  ## Reservoir Sampling Algorithm r](https://en.wikipedia.org/wiki/Reservoir_sampling)
  let now1 = getTime()
  var rng = initRand(now1.nanosecond)

  # [enumerate lines in stdin](https://stackoverflow.com/a/65146313)
  for sIndex, sample in enumerate(lines(stdin)):
    if sIndex < sampleSize:
      result.add(sample)
    else:
      let k: int = rng.rand(sIndex)
      if k < sampleSize:
        result[k] = sample



proc l(sampleSize: int = 3): seq[string] =
  ## Reservoir Sampling Algorithm r](https://en.wikipedia.org/wiki/Reservoir_sampling)
  let now1 = getTime()
  var rng = initRand(now1.nanosecond)

  var h = initHeapQueue[(float, string)]()
  for sample in lines(stdin):
    let r: float = rng.rand(1.0)
    if h.len < sampleSize:
      h.push((r, sample))
    else:
      if r > h[0][0]:
        discard h.pop()
        h.push((r, sample))

  #let variable: seq[string] = collect(newSeq):
  #  for p, sample in h.data: sample
  let variable: seq[string] = collect(newSeq):
    for i in 0 ..< len(h): h[i][1]

  return variable



when isMainModule:
  #let samples = r(3)
  let samples = l(3)
  for sample in samples:
    echo sample
