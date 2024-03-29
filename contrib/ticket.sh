#!/bin/sh
#
# Copyright (c) 2023 Alexander Möller <alexander.moeller@detmold.com>
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

# PURPOSE: Limit the output of todo(1) to at most one task in cases when showing
#          everything that's due might be overwhelming.

TODODIR=${TODODIR:-${HOME}/.todo/}
file_todo=${file_todo:-${TODODIR}/todo.txt}
file_done=${file_done:-${TODODIR}/done.txt}
file_report=${file_report:-${TODODIR}/report.txt}

priority=0

ticket_by_due_date() {
	todo -t "${file_todo}" ld "$2" | grep -v '^---->' | head -1
}

fallback() {
	todo -t "${file_todo}" -d "${file_done}" -r "${file_report}" "$@"
}

while getopts d:r:t:p arg; do
	case ${arg} in
		d) file_done="${OPTARG}" ;;
		r) file_report="${OPTARG}" ;;
		t) file_todo="${OPTARG}" ;;
		p) priority=1 && p="${OPTARG}" ;;
		*) todo usage
	esac
done
shift $((OPTIND - 1))

case $1 in
	ld) ticket_by_due_date "$@" ;;
	*) fallback "$@"
esac
