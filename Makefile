.DEFAULT_GOAL := all

all: install

install:
	mkdir -p ~/bin/ ~/man/man1/
	cp -f todo ~/bin/todo
	cp -f todo.1 ~/man/man1/todo.1

uninstall:
	rm -f ~/bin/todo
	rm -f ~/man/man1/todo.1

.PHONY: all install uninstall
