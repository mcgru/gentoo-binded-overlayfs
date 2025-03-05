#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

mkdir -p $FSDIR
recreate_filesystems(){
( cd $FSDIR
  local L=lower.ext4 U=upper.ext4
  if [ ! -r $U ]; then
  set -x
#    dd if=/dev/zero of=$U bs=1M count=2048
#    mkfs  -t ext4 -F $U
  else
    echo 1>&2 "INFO: $U already exists. Skip ${FUNCNAME[0]}"
  fi
##  mkdir -p lower upper merged
)
}
recreate_filesystems

echo 1>&2 "OK: finished  $0 $*"
exit
