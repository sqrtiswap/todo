.DEFAULT_GOAL := all

all: install

install:
	mkdir -p ~/bin/ ~/man/man1/
	cp -f todo ~/bin/todo
	cp -f ticket ~/bin/ticket
	cp -f todo.1 ~/man/man1/todo.1
	cp -f ticket.1 ~/man/man1/ticket.1

uninstall:
	rm -f ~/bin/todo
	rm -f ~/bin/ticket
	rm -f ~/man/man1/todo.1
	rm -f ~/man/man1/ticket.1

.PHONY: all install uninstall
