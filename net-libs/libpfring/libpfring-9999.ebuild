# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-info git-r3

EGIT_REPO_URI="https://github.com/ntop/PF_RING.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"
S="${WORKDIR}/${PN}/userland/lib"

DESCRIPTION="PF_RING: High-speed packet processing framework (libpfring)"
HOMEPAGE="http://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-kernel/linux-headers"
RDEPEND="${DEPEND}
	sys-kernel/pf_ring-kmod"


src_unpack() {
	git-r3_src_unpack
}

