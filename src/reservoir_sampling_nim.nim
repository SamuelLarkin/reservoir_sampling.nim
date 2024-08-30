# vim:sw=2:ts=2
# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import std/enumerate
import std/heapqueue
#import std/json
import std/math
import std/random
import std/sugar

from std/times import getTime, nanosecond
from system/io import stdin



proc r(population: File, sampleSize: int = 3, seed: int64 = 42): seq[string] =
  ## Reservoir Sampling Algorithm r](https://en.wikipedia.org/wiki/Reservoir_sampling)
  var rng = initRand(seed)

  # [enumerate lines in stdin](https://stackoverflow.com/a/65146313)
  for sIndex, sample in enumerate(lines(population)):
    if sIndex < sampleSize:
      result.add(sample)
    else:
      let k: int = rng.rand(sIndex)
      if k < sampleSize:
        result[k] = sample



proc l(population: File, sampleSize: int = 3, seed: int64 = 42): seq[string] =
  ## Reservoir Sampling Algorithm r](https://en.wikipedia.org/wiki/Reservoir_sampling)
  var rng = initRand(seed)

  var h = initHeapQueue[(float, string)]()
  for sample in lines(population):
    let r: float = rng.rand(1.0)
    if h.len < sampleSize:
      h.push((r, sample))
    else:
      if r > h[0][0]:
        discard h.pop()
        h.push((r, sample))

  #let variable: seq[string] = collect(newSeq):
  #  for p, sample in h.data: sample
  let sample: seq[string] = collect(newSeq):
    for i in 0 ..< len(h): h[i][1]

  return sample



iterator li(population: File, sampleSize: int = 3, seed: int64 = 42): string =
  ## Reservoir Sampling Algorithm r](https://en.wikipedia.org/wiki/Reservoir_sampling)
  var rng = initRand(seed)

  var h = initHeapQueue[(float, string)]()
  for sample in lines(population):
    let r: float = rng.rand(1.0)
    if h.len < sampleSize:
      h.push((r, sample))
    else:
      if r > h[0][0]:
        discard h.pop()
        h.push((r, sample))

  for i in 0 ..< len(h): yield h[i][1]



proc l_optimal(population: File, sampleSize: int = 3, seed: int64 = 42): seq[string] =
  ## Reservoir Sampling Algorithm r](https://en.wikipedia.org/wiki/Reservoir_sampling)
  var rng = initRand(seed)

  # TODO: Fix if sample_size > population
  for i in 0 ..< sample_size:
    result.add(population.readline())

  var W: float = exp(ln(rng.rand(1.0)) / float(sampleSize))
  var nextItemIndex = sampleSize + int(floor(ln(rng.rand(1.0)) / ln(1.0-W))) + 1

  for i, sample in enumerate(population.lines()):
    if i == nextItemIndex:
      let k = rng.rand(sample_size-1)
      result[k] = sample
      W = W * exp(ln(rng.rand(1.0)) / float(sampleSize))
      next_item_index += int(floor(ln(rng.rand(1.0)) / ln(1-W))) + 1



type Algo = enum algo_r, algo_l, algo_lo

proc cli(sampleSize: int=3, algo: Algo=algo_lo, seed: int64 = getTime().nanosecond): void =
  # Test
  stderr.writeLine("Seed for reservoir sampling: ", seed)
  var sampler = r
  case algo:
    of algo_r:
      sampler = r
    of algo_l:
      sampler = l
    of algo_lo:
      sampler = l_optimal

  for sample in sampler(stdin, sampleSize, seed):
    echo sample



when isMainModule:
  import cligen
  dispatch cli, help={
    "sampleSize": "Sample size",
    "algo": "Algorithm implementation type",
    }
