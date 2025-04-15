# How to use overlayfs for background emerge world

## Install

gentoo: `emerge gentoo-binded-overlayfs`

Or copy files to /usr/bin (for example)
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

