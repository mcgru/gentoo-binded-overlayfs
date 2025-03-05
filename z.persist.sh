#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

( set +e
  D=$FSDIR/upper/upper/var/cache/binpkgs
  mkdir -p $D
  grep -Pq "^\S+\s+on\s+${D}\s" <<<$(sudo mount) || \
    sudo mount -m --bind /var/cache/binpkgs $D
)

echo 1>&2 "OK: finished  $0 $*"
exit
