#!/bin/bash


set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

cd $FSDIR
set -x

TGT=world
[ "$#" -gt 0 ] && TGT="$@" ||:
CMD="emerge -1uDNv --with-bdeps=y -gb -j2"
chroot merged /bin/bash -c "$CMD $TGT"


echo 1>&2 "OK: finished  $0 $*"
exit
