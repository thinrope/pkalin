# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="Interface for GDB to Atmel AVR JTAGICE in circuit emulator"
HOMEPAGE="http://avarice.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS="AUTHORS ChangeLog doc/*.txt"

src_prepare() {
	# Debian patches (with rediff) from:
	# https://anonscm.debian.org/cgit/collab-maint/avarice.git/tree/debian/patches
	epatch "${FILESDIR}/dont-link-with-shared-version-of-libbfd.patch"
	epatch "${FILESDIR}/Man-page-fixes.patch"
	epatch "${FILESDIR}/bug-777789-gcc-5.patch"
	epatch "${FILESDIR}/do-not-overwrite-vars.patch"
	epatch "${FILESDIR}/Spelling-fixes.patch"
	epatch "${FILESDIR}/false_null.patch"
	eapply_user
	eautoreconf
}
src_compile() {
	eautomake
}
