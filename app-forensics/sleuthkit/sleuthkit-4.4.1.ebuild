# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${P}.tar.gz"

LICENSE="CPL-1.0 IBM GPL-2"
SLOT="0/13" # subslot = major soname version
KEYWORDS="~amd64"
IUSE="+aff ewf java static-libs threads +zlib"

DEPEND="dev-db/sqlite:3
	ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )
	java? ( dev-java/ant )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	dev-perl/Date-Manip"

DOCS=( ChangeLog.txt NEWS.txt README.md )

PATCHES=( "${FILESDIR}"/${PN}-4.1.0-tools-shared-libs.patch )

S=${WORKDIR}/${PN}-${P}

src_prepare() {
	default
	# gets needed through sleuthkit-4.2.0-set-javac-manually.patch
	eautoreconf
	eapply_user
}

src_configure() {
	local my_econf_args=(
		$(use_enable java)
		$(use_enable threads multithreading)
		$(use_with aff afflib)
		$(use_with ewf libewf)
		$(use_with zlib)
	)
	econf "${my_econf_args[@]}"
}
