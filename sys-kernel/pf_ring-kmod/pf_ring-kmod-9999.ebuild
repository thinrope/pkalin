# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 git-r3

FORK="ntop"
EGIT_REPO_URI="https://github.com/${FORK}/PF_RING.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"
EGIT_BRANCH="master"

DESCRIPTION="PF_RING: High-speed packet processing framework (kernel modules for)"
HOMEPAGE="https://www.ntop.org/products/packet-capture/pf_ring/"
S="${WORKDIR}/${PN}/kernel"

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

CONFIG_CHECK="NET"
ERROR_NET="PF_RING requires CONFIG_NET=y set in the kernel."

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	local modargs=( M="${S}" EXTRA_CFLAGS="-I${S}" BUILD_KERNEL="${KV_FULL}" )
	local modlist=( pf_ring=net/pf_ring:"${S}":"${S}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /usr/include/linux
	doins linux/pf_ring.h || die
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
}
