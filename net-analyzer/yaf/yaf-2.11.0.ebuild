# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="YAF is Yet Another Flowmeter: processes packet data into IPFIX (netflow)"
HOMEPAGE="https://tools.netsa.cert.org/yaf/"
SRC_URI="https://tools.netsa.cert.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
# FIXME: USE=p0f spread not tested
IUSE="applabel entropy +man mpls nonip p0f spread"

DEPEND="
	>=dev-libs/glib-2.6.4
	net-libs/libpcap
	sys-libs/zlib
	>=net-libs/libfixbuf-2.3.0
	applabel? ( >=dev-libs/libpcre-7.3 )
	p0f? ( net-analyzer/p0f )
	spread? ( >=net-misc/spread-4.1 )
"
RDEPEND="${DEPEND}"

src_configure() {
	ECONF_SOURCE="${S}" econf \
	$(use_enable man doxygen-man) \
	$(use_enable entropy) \
	$(use_enable p0f p0fprinter) \
	$(use_enable mpls) \
	$(use_enable nonip)
}
