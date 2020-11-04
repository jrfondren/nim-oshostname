import std/[unittest, options, osproc, strutils]
import oshostname

test "can get a hostname":
  check hostname().isSome

test "hostname() matches shell":
  check hostname().get.string == execProcess("/usr/bin/hostname", options = {}).strip.string
