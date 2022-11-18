# vim:sw=2:ts=2
# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import std/enumerate
#import std/json
import std/random
from std/times import getTime, nanosecond
from system/io import stdin
#import std/os



proc r(sampleSize: int = 3): seq[string] =
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



when isMainModule:
  let samples = r(3)
  for sample in samples:
    echo sample
