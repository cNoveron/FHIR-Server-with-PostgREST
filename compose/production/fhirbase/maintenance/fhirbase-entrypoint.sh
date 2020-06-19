#!/usr/bin/env bash
set -Eeo pipefail

# check to see if this file is being run or sourced from another script
_is_sourced() {
    # https://unix.stackexchange.com/a/215279
    [ "${#FUNCNAME[@]}" -ge 2 ] &&
        [ "${FUNCNAME[0]}" = '_is_sourced' ] &&
        [ "${FUNCNAME[1]}" = 'source' ]
}

_main() {
    export PGHOST="${POSTGRES_HOST}"
    export PGPORT="${POSTGRES_PORT}"
    export PGUSER="${POSTGRES_USER}"
    export PGPASSWORD="${POSTGRES_PASSWORD}"
    export PGDATABASE="${POSTGRES_DB}"

    echo $PGHOST
    echo $PGPORT

    if ! psql -lqt | cut -d \| -f 1 | grep -qw $PGDATABASE; then
        until psql -U $PGUSER -c '\q'; do \
            >&2 echo "Postgres is starting up..."; \
            sleep 5; \
        done && \
            psql -c "create role web_anon nologin;"
            psql -c "grant usage on schema public to web_anon;"
            psql -c "grant web_anon to $PGUSER;"

        fhirbase -d $PGDATABASE -p $PGPORT -n $PGHOST -U $PGUSER -W $PGPASSWORD --fhir=4.0.0 init
        fhirbase -d $PGDATABASE -p $PGPORT -n $PGHOST -U $PGUSER -W $PGPASSWORD load --mode=insert /fhirbase/synthea/output/fhir/*
        fhirbase -d $PGDATABASE -p $PGPORT -n $PGHOST -U $PGUSER -W $PGPASSWORD load --mode=insert /fhirbase/data/*
    fi

    exec "$@"
}

if ! _is_sourced; then
    _main "$@"
fi
