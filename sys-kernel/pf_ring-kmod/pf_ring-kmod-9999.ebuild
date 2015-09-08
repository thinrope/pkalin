# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit linux-mod linux-info git-r3

EGIT_REPO_URI="https://github.com/ntop/PF_RING.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"
S="${WORKDIR}/${PN}/kernel"

DESCRIPTION="PF_RING: High-speed packet processing framework (kernel modules for)"
HOMEPAGE="http://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-kernel/linux-headers"
RDEPEND=""

CONFIG_CHECK="NET"
ERROR_NET="PF_RING requires CONFIG_NET=y set in the kernel."
BUILD_TARGETS="modules"

pkg_setup() {
	linux-mod_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
	MODULE_NAMES="pf_ring(net/pf_ring:${S}:${S})"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} EXTRA_CFLAGS='-I${S}'"
}

src_install() {
	linux-mod_src_install
	insinto /usr/include/linux
	doins linux/pf_ring.h || die
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
