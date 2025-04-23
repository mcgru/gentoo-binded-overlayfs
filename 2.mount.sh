#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

: ${FSTAB:=this.fstab}
mkdir  -p "$FSDIR"

create_base_mountpoints(){
( cd $FSDIR
  set -x
  mkdir -p upper/upper upper/work merged lower
  if [ "$(stat -c %U lower)" != "$USER" ] ; then sudo chown "$USER:$USER" lower upper ; fi
)
}
if [ ! -d "$FSDIR/upper/upper" ] ; then create_base_mountpoints ; fi

create_fstab(){
  ! grep -q "overlayfs" "$FSDIR/$FSTAB"  2>/dev/null  &&  echo "
/  $FSDIR/lower none bind,ro 0 0
overlayfs $FSDIR/merged overlay rw,relatime,lowerdir=lower,upperdir=upper/upper,workdir=upper/work 0 0
/var/cache/binpkgs $FSDIR/merged/var/cache/binpkgs none bind  0 0
/proc $FSDIR/merged/proc none bind  0 0
/dev  $FSDIR/merged/dev  none bind  0 0
/sys  $FSDIR/merged/sys  none bind  0 0
/dev/shm  $FSDIR/merged/dev/shm  none bind  0 0
" > "$FSDIR/$FSTAB"
 :
}
if [ ! -r "$FSDIR/$FSTAB" ] ; then create_fstab ; fi

mount_filesystems(){
  set -x
  sudo mount -T "$FSDIR/$FSTAB" -m -a
  :
}
mount_filesystems

if [ "$(stat -c %a "$FSDIR")" != 700 ] ; then  chmod 700 "$FSDIR" ; fi

echo 1>&2 "OK: finished  $0 $*"
exit
