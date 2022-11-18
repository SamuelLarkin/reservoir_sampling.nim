# vim:sw=2:ts=2
# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import std/enumerate
import std/json
import std/random



proc r(numSample: int = 3): seq[string] =
  var numSample: int = 3
  var reservoir: seq[string] = @[]

  for i, sample in enumerate(stdin.lines):
    if i < numSample:
      reservoir.add(sample)
    else:
      const k = rand(i)
      if k < sample_size:
        reservoir[k] = sample



when isMainModule:
  const samples = r(3)
  for sample in samples:
    echo sample
