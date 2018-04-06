# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

FORK="thinrope"
#FORK="libyal"
DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="https://github.com/libyal/libewf"
EGIT_REPO_URI="https://github.com/${FORK}/libewf"
EGIT_COMMIT="HEAD"

LICENSE="GPL-3"
SLOT="0/2"
KEYWORDS=""
IUSE="bfio debug +ewf +fuse +ssl +static-libs +static +uuid unicode zlib"
REQUIRED_USE="static? ( static-libs )"

DEPEND="
	bfio? ( =app-forensics/libbfio-0.0.20120425_alpha )
	fuse? ( sys-fs/fuse:0
		static? ( sys-fs/fuse:0[static-libs] )
	)
	uuid? ( sys-apps/util-linux
		static? ( sys-apps/util-linux[static-libs] )
	)
	ssl? ( dev-libs/openssl:0
		static? ( dev-libs/openssl:0[static-libs] )
	)
	zlib? ( sys-libs/zlib
		static? ( sys-libs/zlib[static-libs] )
	)"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS ChangeLog NEWS README documents/header.txt documents/header2.txt )

src_prepare() {
	"${WORKDIR}/${P}/synclibs.sh"
	eautoreconf
	eapply_user
}

src_configure() {
	local myconf="--without-bzip2"
	econf \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		$(use_enable ewf v1-api) \
		$(use_enable unicode wide-character-type) \
		$(use_enable static-libs static) \
		$(use_enable static static-executables) \
		$(use_with zlib) \
		$(use_with bfio libbfio) \
		$(use_with ssl openssl) \
		$(use_with uuid libuuid) \
		$(use_with fuse libfuse) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	doman manuals/*.1 manuals/*.3
}
