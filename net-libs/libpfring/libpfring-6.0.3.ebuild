# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils linux-info git-r3

EGIT_REPO_URI="https://github.com/ntop/PF_RING.git"
EGIT_COMMIT="d11496f8abe8c1fc1ab5d6f1bb23182c54ac4a89"
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
	=sys-kernel/pf_ring-kmod-${PV}"
