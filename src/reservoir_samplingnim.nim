# vim:sw=2:ts=2
# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import std/enumerate
#import std/json
import std/random
from std/times import getTime, nanosecond



proc r(numSample: int = 3): seq[string] =
  let now1 = getTime()
  var rng = initRand(now1.nanosecond)

  var reservoir: seq[string] = @[]

  # [enumerate lines in stdin](https://stackoverflow.com/a/65146313)
  #for (i, sample) in enumerate(stdin.lines):
  #let f = open(stdin)
  #defer: f.close()
  #for s_index, sample in enumerate(lines(f)):
  #for s_index, sample in enumerate(lines(stdin)):
  let s_index: int=0
  for sample in stdin.lines:
    if s_index < numSample:
      reservoir.add(sample)
    else:
      const k = rng.rand(s_index)
      if k < sample_size:
        reservoir[k] = sample



when isMainModule:
  const samples = r(3)
  for sample in samples:
    echo sample
