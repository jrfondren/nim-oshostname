#! /usr/bin/env nimcr
import oshostname, options
let hostname = hostname().get(otherwise = TaintedString("example.com")).string
echo hostname
