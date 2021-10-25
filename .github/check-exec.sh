#!/usr/bin/env bash
set -o pipefail

NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'

ERRORCODE=0

# Make sure no files in docs/ are executable
EXEC_PERM_COUNT=$(find docs -type f -perm /111 | wc -l)
echo "=> Checking $(pwd)/docs for executable permissions..."
echo
if [ "${EXEC_PERM_COUNT}" -ne 0 ]
then
  echo '✖ ERROR: Executable permissions should not be used in documentation! Use `chmod 644` to the files in question:' >&2
  find docs -type f -perm /111
  ((ERRORCODE++))
fi

if [ $ERRORCODE -ne 0 ]
then
  RESULT="✖ ${ERRORCODE} lint test(s) failed. Review the log carefully to see full listing."
  echo -e "$RED Failed $RESULT: $NC"
  echo ::set-output name=result::"$RESULT"
  exit 1
else
  RESULT="✔ Linting passed"
  echo -e "$GREEN $RESULT $NC"
  echo ::set-output name=result::"$RESULT"
  exit 0
fi