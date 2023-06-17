# todo

todo.txt-cli replacement with a focus on portability

## Some introductory remarks that can be safely skipped

### Why?
I happily used [todo.txt-cli](https://github.com/todotxt/todo.txt-cli) until 2019 when I started using OpenBSD.
With OpenBSD by default using `ksh(1)` instead of `bash(1)` the script didn't work anymore - which of course isn't a big surprise.

But even after installing `bash(1)` it still didn't work. Looking back I have no idea why that was the case but at that time it looked like todo.txt-cli was not just `bash(1)` specific but even specific to specific `bash(1)` versions/ports.

When I looked at the code I was shocked even more at some of the design decisions (I don't think I would judge it so harshly nowadays but I did then) and therefore decided to write my own replacement with a focus on portability.

### Why and how purely POSIX?
By now this is also kind of a proof of principle to see if I can implement everything I want in a purely POSIX way.
Hence I made some decisions that might themselves seem weird/shocking, e.g.:
- The `-i` flag is an extension to `sed(1)` and therefore not allowed. `ed(1)` to the rescue! ;)
- The `-j` in MacOS and `-d` in GNU `date(1)` are extension, so an ugly workaround is needed.

This also means: If it doesn't work for your obscure (but POSIX compliant) system, please tell me about it and I'll get it working.

## Differences to todo.txt-cli
- Not all features are available, only those I care about.
- Some additional features exist because I care about them.
- The features both scripts share may be behind different flags and commands. I just didn't care about keeping the same syntax.
- Inspired by [Simpletask](https://github.com/mpcjanssen/simpletask-android) every task starts with the creation date (`+%F`) and may have a due date (`due:+%F`), e.g. `2023-06-17 (B) Do this thing @context +project due:2023-06-18`.

## Installation

```shell
make
```
will move `todo` to `~/bin/` and the manpage to `~/man/man1/`.

## Removal

```shell
make uninstall
```

## Documentation

RTFM

## License
[ISC](https://opensource.org/licenses/ISC)
