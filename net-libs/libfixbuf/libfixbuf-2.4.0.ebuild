# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="IPFIX Protocol library, for building IPFIX Collecting and Exporting Processes"
HOMEPAGE="https://tools.netsa.cert.org/fixbuf/"
SRC_URI="https://tools.netsa.cert.org/releases/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
# FIXME: USE=spread not tested
IUSE="spread +man"

DEPEND="
	man? ( app-doc/doxygen )
	spread? ( net-misc/spread )
"
src_configure() {
	ECONF_SOURCE="${S}" econf \
	$(use_enable man doxygen-man)
}
