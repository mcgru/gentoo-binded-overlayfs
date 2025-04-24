# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Utility for background emergeing world in overlayed filesystem and saving packages in binpkgs"
HOMEPAGE="https://github.com/mcgru/gentoo-binded-overlayfs"
#MY_PN=${PN%%-bin}
#MY_P=${MY_PN}-${PV}
###SRC_URI="https://github.com/prometheus/prometheus/releases/download/v${PV}/${MY_P}.linux-amd64.tar.gz"
#SRC_URI="https://github.com/mcgru/gentoo-binded-overlayfs.git"

EGIT_REPO_URI="${HOMEPAGE}.git"
#EGIT_BRANCH="main"  # Укажите нужную ветку, если требуется
EGIT_COMMIT="7371410"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

#DEPEND="${BDEPEND} "
#DEPEND="acct-group/prometheus
#	acct-user/prometheus
#	!app-metrics/prometheus"
#RDEPEND="${DEPEND}"

#S="${WORKDIR}/${MY_P}.linux-amd64"

src_install() {
#### lighttpd.conf.add
	exeinto /usr/share/$PN
	doexe   1.cleanup.sh 2.mount.sh 5.emerge.sh 8.pure.emerge.sh 9.umount.sh z.full.emerge-world.sh
	dosym   /usr/share/$PN/z.dispatch.sh /usr/bin/proxify-emerge-world
	insinto /usr/share/$PN
	cp -f common.conf.varlib $T/common.conf
	doins   $T/common.conf

	keepdir /var/lib/$PN
}

#pkg_postinst() {
#}
