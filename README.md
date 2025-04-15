# How to use overlayfs for background emerge world

## Install

gentoo (emerge if in portage):
```
emerge gentoo-binded-overlayfs
```
gentoo (via ebuild):
```
ebuild digest gentoo-binded-overlayfs-1.3-r6.ebuild
ebuild merge  gentoo-binded-overlayfs-1.3-r6.ebuild
```

Or copy files and scripts to /usr/bin (for example)
and make symlink proxify-emerge-world to z.full.emerge-world.sh

## Usage

to prepare binary packages for world
```
proxify-emerge-world
```

to prepare binary packages for specific package
```
proxify-emerge-world PACKAGENAME
```

