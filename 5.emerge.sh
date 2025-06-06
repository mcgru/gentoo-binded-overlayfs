#!/bin/bash

set -euo pipefail
set -a ; THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

cd "$FSDIR"
set -x

TGT=world
CMD="emerge -1uDNv --with-bdeps=y -gb -j2"

[ "$#" -gt 0 ] && TGT="$@" ||:
[ "$TGT" != world ] && CMD="emerge -1gb -j2" ||:

if [ -x ./pre-emerge.hook.sh ]; then
  cp -a ./pre-emerge.hook.sh -f -t merged
  chroot merged /bin/bash -c "/pre-emerge.hook.sh"
fi

  chroot merged /bin/bash -c "$CMD  $TGT"

echo 1>&2 "OK: finished  $0 $*"
