# Reservoir Sampling

An excuse to try out `nim`.

## Compile
First install the dependencies.
```sh
nimble install cligen
```

Then, from now on, you can do the following to compile:
```sh
nimble build
```

If you want to run the code with `nimble`.
```sh
nimble run -- --sampleSize=10000 < corpus |& less
```
or
```sh
reservoir_samplingnim --sampleSize=10000 < corpus |& less
```


## Documentation
* [Nim Documentation](https://nim-lang.org/docs)
* [Nim for Python Programmers](https://github.com/nim-lang/Nim/wiki/Nim-for-Python-Programmers)
* [Nim Learning X in Y minutes](https://learnxinyminutes.com/docs/nim/)
* [Nim by Example](https://nim-by-example.github.io/for_iterators)
* [Nim Introduction](https://narimiran.github.io/nim-basics)
* [Nim w3cub](https://docs.w3cub.com/nim)


## Libraries
* [nim - itertools](https://narimiran.github.io/itertools/)
