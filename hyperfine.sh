#!/bin/bash

readonly corpus=corpus


hyperfine \
   --shell bash \
   --prepare "zcat --force $corpus" \
   --export-json hyperfine.text.json \
   --style full \
   "./reservoir_sampling_nim --algo algo_r < $corpus" \
   "./reservoir_sampling_nim --algo algo_l < $corpus" \
   "./reservoir_sampling_nim --algo algo_lo < $corpus"
