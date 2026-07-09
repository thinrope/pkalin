# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="PF_RING"	# upstream calls it this way
MY_P="${MY_PN}-${PV}"
COMMIT_HASH="53d901fbf55e8a1df156a4511a992703c141411c" # HEAD of 9.2.0-stable, last commit 2026-04-30

DESCRIPTION="PF_RING: High-speed packet processing framework (libpfring)"
HOMEPAGE="https://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI="https://github.com/ntop/${MY_PN}/archive/${COMMIT_HASH}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT_HASH}/userland"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="sys-devel/bison
	app-alternatives/lex"
RDEPEND="${DEPEND}
	~sys-kernel/pf_ring-kmod-${PV}"

src_prepare(){
	cd lib/
	# install shared libraries only
	sed -i "s|install: install-static install-shared|install: install-shared|" Makefile.in || die

	sed -i "s|${INSTDIR}/lib|${INSTDIR}/$(get_libdir)|" Makefile.in || die
	sed -i "s|lib64nbpf.a|libnbpf.a|" Makefile.in || die
	eapply_user
}

src_compile(){
	emake -j1
}

src_install() {
	cd lib/
	emake DESTDIR="${D}" install
	dosym libpfring.so usr/$(get_libdir)/libpfring.so.1
	# FIXME: Do we need to install nbpftest
}
