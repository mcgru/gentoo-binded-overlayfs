#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

cd $FSDIR
set -x

CMD="emerge"
TGT=""
[ "$#" -gt 0 ] && TGT="$@" ||:
chroot merged /bin/bash -c "$CMD $TGT"


echo 1>&2 "OK: finished  $0 $*"
exit
