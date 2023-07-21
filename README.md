# oshostname

> Get the current hostname with gethostname(2)

## Support platforms

Currently, just any that support gethostname() similarly to Linux.

## Why even use this?

EDIT: don't. I don't know how i missed it, but std/nativeosckets has getHostname() already, for windows and Posix platforms, including macOS.

gethostname() has this gotcha: if the configured hostname is longer than the
buffer given to it, then the buffer might not be NUL terminated. This library
takes the small amount of care required to avoid this case.

In the future it might also grow support for other platforms.

## Usage

Add the following to your .nimble file:

```
requires "oshostname >= 0.1.0"
```

Then use the provided hostname() proc:

```nim
import oshostname, options
echo hostname().get
```

In this code, if gethostbyname() fails, that `.get` will fail with an
`UnpackDefect`.
