# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 autotools toolchain-funcs

DESCRIPTION="A network sniffer for DNS server replies"
HOMEPAGE="https://github.com/gamelinux/passivedns"
SRC_URI=""
EGIT_REPO_URI="git://github.com/gamelinux/passivedns.git"
EGIT_COMMIT="HEAD"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=net-libs/ldns-1.6.17
		>=net-libs/libpcap-1.7.4"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_compile() {
	cd "${S}/src"
	emake
}

src_install() {
	cd "${S}/src"
	dobin passivedns
	dodoc -r "${S}/doc"
}
