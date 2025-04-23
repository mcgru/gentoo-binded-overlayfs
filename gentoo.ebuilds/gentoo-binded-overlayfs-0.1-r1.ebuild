EAPI=8

inherit git-r3

DESCRIPTION="Utility for background emergeing world in overlayed filesystem and saving packages in binpkgs"
HOMEPAGE="https://github.com/mcgru/gentoo-binded-overlayfs"
#SRC_URI="https://github.com/mcgru/gentoo-binded-overlayfs.git"

EGIT_REPO_URI="${HOMEPAGE}.git"
#EGIT_BRANCH="main"
EGIT_COMMIT="c579514"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

#DEPEND="${BDEPEND} "
#RDEPEND="${DEPEND}"

src_install() {
#### lighttpd.conf.add
        exeinto /usr/share/$PN
        doexe   1.cleanup.sh 2.mount.sh 4.emerge-world.sh 8.pure.emerge.sh 9.umount.sh z.full.emerge-world.sh
        dosym   /usr/share/$PN/z.full.emerge-world.sh /usr/bin/proxify-emerge-world
        insinto /usr/share/$PN
        cp -f common.conf.varlib $T/common.conf
        doins   $T/common.conf

        keepdir /var/lib/$PN
}
