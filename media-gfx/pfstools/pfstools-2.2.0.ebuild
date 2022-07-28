# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="A set of command line programs for reading, writing and manipulating HDR images"
HOMEPAGE="http://pfstools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug qt netpbm octave openexr tiff"

RDEPEND="
	netpbm? ( media-libs/netpbm )
	octave? ( sci-mathematics/octave )
	openexr? ( >=media-libs/openexr-1.0 )
	tiff? ( media-libs/tiff )"
	# FIXME: qt?
DEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_MATLAB=false
		-DWITH_QT=$(usex qt)
		-DWITH_ImageMagick=false
		-DWITH_NetPBM=$(usex netpbm)
		-DWITH_pfsglview=false
		-DWITH_TIFF=$(usex tiff)
		-DWITH_OpenEXR=$(usex openexr)
		-DWITH_Octave=$(usex octave)
	)
	cmake_src_configure
}

