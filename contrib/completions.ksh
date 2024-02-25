#!/bin/ksh

if [ -d "$TODODIR" ]; then
	set -A complete_todo_1 -- -b -d -r -t -p -q \
		append \
		create \
		'done' \
		edit \
		finished \
		lc \
		ld \
		lp \
		ls \
		priority \
		report \
		today
	set -A complete_todo -- append \
		create \
		'done' \
		edit \
		finished \
		lc \
		ld \
		lp \
		ls \
		priority \
		report \
		today
fi
