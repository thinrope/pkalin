# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod linux-info git-r3

FORK="ntop" #use thinrope for more stable :-D

EGIT_REPO_URI="https://github.com/${FORK}/PF_RING.git"
EGIT_BRANCH="master"
EGIT_COMMIT="HEAD"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"

DESCRIPTION="PF_RING: High-speed packet processing framework (kernel modules for)"
HOMEPAGE="http://www.ntop.org/products/packet-capture/pf_ring/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/kernel"

MODULE_NAMES="pf_ring(net/pf_ring:${S}:${S})"
CONFIG_CHECK="NET"
ERROR_NET="PF_RING requires CONFIG_NET=y set in the kernel."
BUILD_TARGETS="modules"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="-C ${KV_DIR} M=${S} EXTRA_CFLAGS='-I${S}'"
}

src_unpack() {
	git-r3_src_unpack
}

src_install() {
	linux-mod_src_install
	insinto /usr/include/linux
	doins linux/pf_ring.h || die
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
