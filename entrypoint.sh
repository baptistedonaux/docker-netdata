#!/bin/bash

# If the first argument is not an executable, prepend "netdata"
if ! type -- "$1" &>/dev/null; then
	set -- netdata -nodeamon "$@"
fi

exec "$@"
