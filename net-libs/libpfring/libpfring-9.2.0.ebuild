# Copyright 2018-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info git-r3

FORK="ntop"
EGIT_REPO_URI="https://github.com/${FORK}/PF_RING.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"
EGIT_BRANCH="${PV}-stable"

DESCRIPTION="PF_RING: High-speed packet processing framework (libpfring)"
HOMEPAGE="https://www.ntop.org/products/packet-capture/pf_ring/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}/userland"

DEPEND="sys-kernel/linux-headers
	sys-process/numactl"
RDEPEND="${DEPEND}
	~sys-kernel/pf_ring-kmod-${PV}"

src_configure() {
	set -- "${S}/configure" \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--mandir="${EPREFIX}/usr/share/man" \
	echo "${@}"
	"${@}" || die
}

src_compile() {
	MAKEOPTS=-j1
	emake ${PN}
}

src_install() {
	cd lib/
	emake DESTDIR="${D}" install-includes
	default
	# FIXME: Do we need to install nbpftest
}
