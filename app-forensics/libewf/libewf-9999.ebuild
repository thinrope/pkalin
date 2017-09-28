# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

FORK="thinrope"
DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="https://github.com/${FORK}/libewf"
EGIT_REPO_URI="https://github.com/${FORK}/libewf"
EGIT_COMMIT="HEAD"

LICENSE="GPL-3"
SLOT="0/2"
KEYWORDS=""
IUSE="bfio debug +ewf +fuse +ssl static-libs +uuid unicode zlib"

DEPEND="
	sys-libs/zlib
	bfio? ( =app-forensics/libbfio-0.0.20120425_alpha )
	fuse? ( sys-fs/fuse:0 )
	uuid? ( sys-apps/util-linux )
	ssl? ( dev-libs/openssl:0 )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS ChangeLog NEWS README documents/header.txt documents/header2.txt )

src_prepare() {
	"${WORKDIR}/${P}/synclibs.sh"
	eautoreconf
	eapply_user
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
		$(use_enable ewf v1-api)
		$(use_enable unicode wide-character-type)
		$(use_with zlib)
		# autodetects bzip2 but does not use
		--without-bzip2
		$(use_with bfio libbfio)
		$(use_with ssl openssl)
		$(use_with uuid libuuid)
		$(use_with fuse libfuse)
	)
	econf $myeconfargs
}

src_install() {
	emake DESTDIR="${D}" install
	doman manuals/*.1 manuals/*.3
}
