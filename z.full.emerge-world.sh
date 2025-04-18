#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

trap "$CWD/9.umount.sh" EXIT INT QUIT TERM KILL

$CWD/2.mount.sh
$CWD/4.emerge-world.sh "$@"
