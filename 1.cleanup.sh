#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

$CWD/9.umount.sh ||:

mkdir  -p "$FSDIR"

remove_base_mountpoints(){
( cd $FSDIR
  rm -rf upper
)
}
remove_base_mountpoints

echo 1>&2 "OK: finished  $0 $*"
exit
