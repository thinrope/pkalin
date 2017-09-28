# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils linux-info git-r3

EGIT_REPO_URI="https://github.com/ntop/PF_RING.git"
EGIT_COMMIT="HEAD"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"

DESCRIPTION="PF_RING: High-speed packet processing framework (libpfring)"
HOMEPAGE="http://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

S="${WORKDIR}/${PN}/userland/lib"

DEPEND="sys-kernel/linux-headers"
RDEPEND="${DEPEND}
	=sys-kernel/pf_ring-kmod-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-6.6.0_soname.patch"
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
	newlib.so ${PN}.so ${PN}.so.1
	dosym ${PN}.so.1 "/usr/$(get_libdir)/${PN}.so"
	use static-libs && dolib ${PN}.a

}
