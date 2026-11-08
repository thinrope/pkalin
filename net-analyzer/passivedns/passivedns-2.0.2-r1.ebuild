# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A network sniffer for DNS server replies"
HOMEPAGE="https://github.com/gamelinux/passivedns"
SRC_URI="https://github.com/gamelinux/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pfring"

DEPEND=">=net-libs/ldns-1.7.1-r5
		>=net-libs/libpcap-1.10.0-r1
		pfring? ( net-libs/libpfring )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	# dev-libs/jansson is not needed, will be dropped soon
	# REF: https://github.com/gamelinux/passivedns/issues/142#issuecomment-6724158831
	econf --disable-json $(use_enable pfring pfring)
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
