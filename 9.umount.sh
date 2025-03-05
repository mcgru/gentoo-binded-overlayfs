#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

unmount_filesystems(){
( cd $FSDIR
  set -x +e
  sudo umount -R merged
  sudo umount -R upper
  sudo umount -R lower
)
}
unmount_filesystems

echo 1>&2 "OK: finished  $0 $*"
exit
