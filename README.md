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
- The `-j` in MacOS and `-d` in GNU `date(1)` are extensions, so an ugly workaround is needed.

This also means: If it doesn't work for your obscure (but POSIX compliant) system, please tell me about it and I'll get it working.

## Differences to todo.txt-cli
- Not all features are available, only those I care about.
- Some additional features exist because I care about them.
- The features both scripts share may be behind different flags and commands. I just didn't care about keeping the same syntax. Sometimes a different command also made more sense, e.g. since I wanted to (in most cases) be able to use single-letter-commands as abbreviations for the full commands I changed `add` to `create` in order for `add` and `append` not to conflict. For more details see the documentation.
- In the official [todo.txt format rules](https://github.com/todotxt/todo.txt#todotxt-format-rules) the creation date is an option, in `todo(1)` it's always added. This is also the case for the completion date as well as the priority.
- Furthermore the order of priority and completion date in `done.txt` is reversed, e.g. an entry might be `x 2023-06-21 (C) 2023-06-20 Do this thing @context +project due:2023-06-21`.

## Installation

```shell
make
```
will move `todo` to `~/bin/` and the manpage to `~/man/man1/`. You may need to update your `MANPATH`.

## Removal

```shell
make uninstall
```

## Documentation

RTFM

## License
[ISC](https://opensource.org/licenses/ISC)
