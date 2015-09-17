# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools-utils

DESCRIPTION="A library and a collection of comand line tools for forensic analysis of disk images"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="CPL-1.0 IBM GPL-2"
SLOT="0/13" # subslot = major soname version
KEYWORDS="~amd64"
IUSE="aff ewf static-libs"		# FIXME: add java support

DEPEND="dev-db/sqlite:3
	ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND}
	dev-perl/DateManip"

DOCS=( NEWS.txt README.md )

PATCHES=(
	"${FILESDIR}"/${PN}-4.1.0-system-sqlite.patch
	"${FILESDIR}"/${PN}-4.1.0-tools-shared-libs.patch
)

src_configure() {
	local myeconfargs=(
		$(use_with aff afflib)
		$(use_with ewf libewf)
	)
	autotools-utils_src_configure
}
