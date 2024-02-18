#!/bin/bash

# exit on errors or uninitalised vars
set -Eeuo pipefail
# set -x && PS4='Line ${LINENO}: '

trap cleanup SIGINT SIGTERM EXIT
trap 'handle_error $LINENO' ERR

cleanup() {
    trap - SIGINT SIGTERM EXIT
    rm -r ${TEMP_DOCS_DIR}
}
handle_error() {
    cleanup
    echo "INFO: The error occurred on line: $1"
    exit 1
}

EXEC_DIR="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P)"
TEMP_DOCS_DIR="${SCRIPT_DIR}/temp_docs"
# hardcoded to prevent anyone deleting the wrong folder contents
DESTINATION_DIR="${SCRIPT_DIR}/../folder2/nestedfolder2"

# script logic here

# cd, because needed config file and templates are inside
cd $SCRIPT_DIR

# download file if nonexistent
FILE=${SCRIPT_DIR}/thefile
if [ -f "$FILE" ]; then
    ### TODO download file
fi
### TODO check checksum
### TODO installation

# create dir if needed
[ -d $TEMP_DOCS_DIR  ] || mkdir $TEMP_DOCS_DIR
# generate docs
#tbls doc
echo "generating docs..."
touch "${TEMP_DOCS_DIR}/doc1" "${TEMP_DOCS_DIR}/doc2"
# inject needed files and rename `readme` to prevent wrong rendering by docusaurus
### TODO
# mv
# mv
### DUMMYFILE for debugging
touch "${DESTINATION_DIR}/dummyfile" "${DESTINATION_DIR}/dummyfile2"
# delete old docs and move up-to-date docs to correct dir
rm ${DESTINATION_DIR}/* || true
mv -t $DESTINATION_DIR ${TEMP_DOCS_DIR}/*
