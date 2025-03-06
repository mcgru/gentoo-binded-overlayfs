#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

: ${FSTAB:=this.fstab}
mkdir -p $FSDIR

create_some_mountpoints(){
( cd $FSDIR
  set -x
  mkdir -p upper/upper upper/work merged lower
  sudo chown "$USER:$USER" lower upper
)
}
[ ! -d "$FSDIR/upper/upper" ] && create_some_mountpoints

create_fstab(){
( cd $FSDIR
  echo "
/  $FSDIR/lower none bind,ro 0 0
overlayfs $FSDIR/merged overlay rw,relatime,lowerdir=lower,upperdir=upper/upper,workdir=upper/work 0 0
/var/cache/binpkgs $FSDIR/merged/var/cache/binpkgs none bind  0 0
/proc $FSDIR/merged/proc none bind  0 0
/dev  $FSDIR/merged/dev  none bind  0 0
/sys  $FSDIR/merged/sys  none bind  0 0
" > $FSTAB
)
}
[ ! -r "$FSTAB" ] && create_fstab

mount_filesystems(){
( cd $FSDIR
  set -x
  sudo mount -T $FSTAB -m -a
  sudo chown "$USER:$USER" lower upper
)
}
mount_filesystems

echo 1>&2 "OK: finished  $0 $*"
exit
