#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

cd $FSDIR
set -x

DOSYNC=""
if grep -qP "^[-]*sync" <<<"${1:-noVal}" ; then
  DOSYNC=da-do-sync
  shift 1
fi

TGT=world
[ "$#" -gt 0 ] && TGT="$@" ||:

#CMD="emerge -1uDNv --with-bdeps=y -gb -j2"
#chroot merged /bin/bash -c "$CMD $TGT"

__chroot(){
  local CMD="${1:?need CMD as arg1 in ${FUNCNAME[0]}}"
  local TGT="${2}"
  chroot merged /bin/bash -c "$CMD  $TGT"
}

if [ "$DOSYNC" ]; then
__chroot emaint sync
fi

__chroot "emerge -1uDNv --with-bdeps=y -gb -j2" "$TGT"


echo 1>&2 "OK: finished  $0 $*"
exit
