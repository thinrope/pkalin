# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils linux-info

DESCRIPTION="PF_RING: High-speed packet processing framework (libpfring)"
HOMEPAGE="http://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI="https://github.com/ntop/PF_RING/archive/${PV}.tar.gz -> PF_RING-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

S="${WORKDIR}/PF_RING-${PV}/userland/lib"

DEPEND="sys-kernel/linux-headers
sys-process/numactl"

RDEPEND="${DEPEND}
	=sys-kernel/pf_ring-kmod-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}_soname.patch"
	epatch "${FILESDIR}/${P}_jobserver.patch"
	eapply_user
}

src_configure() {
	set -- "${S}/configure" \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--mandir="${EPREFIX}/usr/share/man" \
	echo "${@}"
	"${@}" || die
}

src_install() {
	emake DESTDIR="${D}" install-includes
	newlib.so ${PN}.so ${PN}.so.1
	dosym ${PN}.so.1 "/usr/$(get_libdir)/${PN}.so"
	use static-libs && dolib ${PN}.a
	# FIXME: Do we need to install nbpftest
}
