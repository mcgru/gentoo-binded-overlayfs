#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

mkdir -p $FSDIR
recreate_filesystems(){
( cd $FSDIR
  local L=lower.ext4 U=upper.ext4
  if [ ! -r $L ]; then
  set -x
##    echo 1>&2 "INFO: going to create empty 10GB file $L"
#    dd if=/dev/zero of=lower.ext4 bs=1M count=10240
##    echo 1>&2 "INFO: create filesystem on $L"
#    mkfs  -t ext4 -F lower.ext4
##    echo 1>&2 "INFO: copy $L to $U"
#    cp -f lower.ext4 upper.ext4
##    echo 1>&2 "INFO: create filesystem on $U"
#    mkfs  -t ext4 -F upper.ext4
  else
    echo 1>&2 "INFO: $L already exists. Skip ${FUNCNAME[0]}"
  fi
  mkdir -p lower upper merged bind-root
)
}
recreate_filesystems

echo 1>&2 "OK: finished  $0 $*"
exit
