##[
This module fetches the hostname of operating system that this program is
running in, currently just with gethostbyname(2) on platforms supporting that.
]##

import options

proc gethostname(name: cstring, len: csize_t): int32
  {.cdecl, importc: "gethostname", header: "<unistd.h>".}

let HOST_NAME_MAX {.importc: "HOST_NAME_MAX", header: "<unistd.h>".}: csize_t

proc hostname*(): Option[TaintedString] =
  ## Returns the system hostname if it can be determined. The return value is
  ## from the `options<https://nim-lang.org/docs/options.html>`_ module.
  # +1 so that a NUL byte follows the hostname even if it's too long
  runnableExamples:
    import oshostname, options
    let hostname1 = hostname().get  # Defect if can't get hostname
    let hostname2 = hostname().get(otherwise = TaintedString("example.com"))
  var buf = cast[cstring](alloc0(HOST_NAME_MAX+1))
  if 0 == gethostname(buf, HOST_NAME_MAX):
    result = some(TaintedString($buf))
  else:
    result = none[TaintedString]()
  dealloc(buf)
