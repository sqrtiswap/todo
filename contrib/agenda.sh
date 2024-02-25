#!/bin/sh
#
# Copyright (c) 2024 Alexander Möller <alexander.moeller@detmold.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# PURPOSE: Have an agenda for the day, that includes multiple different todo(1)
#          directories as well as perhaps the output of further tools like cli
#          calendars, etc.
#
#          In this example there are two TODODIR used that have to be exported
#          to be available, e.g. in the shell config:
#          export TODODIR=/path/to/a/tododir
#          export WORKTODODIR=/path/to/another/tododir
#
#          One might want something to use as a separator between the two (or
#          however many outputs). As an example there is drawsep, which can be
#          found at https://github.com/sqrtiswap/dotfiles/blob/main/bin/drawsep

date_today=$(date +%Y-%m-%d)

check_due_dates() {
	n=0
	for x in ${due_dates} ; do
		if [ "$n" -eq 0 ] && expr "$x" \<= "due:$date_today" > /dev/null ; then
			n=1
		else
			break
		fi
	done
}

show_tasks() {
	due_dates=$(grep "$1" "$TODODIR"/todo.txt | grep -oh 'due:[[:graph:]]*' | sort -u)
	if [ -n "${due_dates}" ] ; then
		check_due_dates
		if [ "$n" -eq 1 ] ; then
			#drawsep 'PRIVATE todo'
			todo today "$1"
		fi
	fi

	due_dates=$(grep "$1" "$WORKTODODIR"/todo.txt | grep -oh 'due:[[:graph:]]*' | sort -u)
	if [ -n "${due_dates}" ] ; then
		check_due_dates
		if [ "$n" -eq 1 ] ; then
			#drawsep 'WORK todo'
			TODODIR=$WORKTODODIR todo today "$1"
		fi
	fi
}

if [ -z "$1" ] ; then
	# run a bunch of stuff when no keyword is provided for matching
	show_tasks
else
	# reduce to only show todo(1) output when a keyword is provided for matching
	show_tasks "$@"
fi
