#!/usr/bin/env bash
set -Eeo pipefail


# check to see if this file is being run or sourced from another script
_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}

_main() {
    export PGHOST="${POSTGRES_HOST}"
    export PGPORT="${POSTGRES_PORT}"
    export PGUSER="${POSTGRES_USER}"
    export PGPASSWORD="${POSTGRES_PASSWORD}"
    export PGDATABASE="${POSTGRES_DB}"

    echo $PGHOST
    echo $PGPORT

    # if first arg looks like a flag, assume we want to run postgres server
	if [ "${1:0:1}" = '-' ]; then
        echo 'FUNCTION NUMERO 1'
		set -- postgres "$@"
	fi

	if [ "$1" = 'postgres' ] && ! _pg_want_help "$@"; then
    echo 'FUNCTION NUMERO 2'
	fi

    exec "$@"
}

if ! _is_sourced; then
	_main "$@"
fi
