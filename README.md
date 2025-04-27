# How to use overlayfs for background emerge world

## Install

gentoo (emerge if in portage):
```
emerge gentoo-binded-overlayfs
```
gentoo (via ebuild):
```
ebuild digest gentoo-binded-overlayfs.ebuild
ebuild merge  gentoo-binded-overlayfs.ebuild
```

Or copy files and scripts to /usr/bin (for example)
and make symlink proxify-emerge-world to z.dispatch.sh

## Usage

to prepare binary packages for world
```
proxify-emerge-world
```

to prepare binary packages for specific package
```
proxify-emerge-world PACKAGENAME
```

--------

[What AI thinks wbout it](https://deepwiki.com/mcgru/gentoo-binded-overlayfs/)
