#!/bin/bash

set -euo pipefail
set -a ;THIS=$(realpath -P $0); CWD=$(dirname "$THIS"); source "$CWD"/common.conf; [ -r "${THIS%.sh}.conf" ] && source "${THIS%.sh}.conf";  set +a

mount_filesystems(){
( cd $FSDIR
  set -x
#  sudo mount lower.ext4 lower
#  sudo mount upper.ext4 upper
  sudo chown "$USER:$USER" lower upper
#  sudo mount -o remount,ro lower.ext4 lower
#  local L=lower.ext4 U=upper.ext4
#mkdir -p upper/upper upper/merged upper/work

sudo mount --bind -o ro / bind-root

# Create the overlay mount.
sudo mount \
  -t overlay \
  -o lowerdir=lower:bind-root,upperdir=upper/upper,workdir=upper/work \
  overlayfs \
  merged
###  upper/merged \
#;
for i in proc dev sys; do sudo mount --bind /$i merged/$i  ; done
)
}
mount_filesystems

echo 1>&2 "OK: finished  $0 $*"
exit
