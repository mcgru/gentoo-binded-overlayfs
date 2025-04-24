#!/bin/bash

ARG=$1
set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

case "$ARG" in
  -mount|--mount) shift 1 ;
     trap "" EXIT INT QUIT TERM KILL
     $CWD/2.mount.sh
     ;;
  -umou*|--umou*) shift 1 ;
     trap "" EXIT INT QUIT TERM KILL
     $CWD/9.umount.sh
     ;;
  -clea*|--clea*) shift 1 ;
     trap "" EXIT INT QUIT TERM KILL
     $CWD/1.cleanup.sh
     ;;
  -sync|--sync)   shift 1 ;
     trap "$CWD/9.umount.sh" EXIT INT QUIT TERM KILL
     $CWD/2.mount.sh
     chroot merged /bin/bash -c "emaint sync"
     ;;
  *)
     trap "$CWD/9.umount.sh" EXIT INT QUIT TERM KILL
     $CWD/2.mount.sh
     $CWD/5.emerge.sh "$@"
     ;;
esac

exit $?
