#!/bin/bash

# If the first argument is not an executable, prepend "hhvm"
if ! type -- "$1" &>/dev/null; then
	set -- netdata -nodeamon "$@"
fi

exec "$@"
