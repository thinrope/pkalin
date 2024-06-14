# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.sits.lu/xmount"
SRC_URI="https://code.sits.lu/foss/xmount/-/archive/${PV}/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+aff +ewf"

BDEPEND="virtual/pkgconfig"
RDEPEND="sys-libs/zlib
	sys-fs/fuse:*
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}"

# FIXME: USEFLAGS are currently ignored, pingged upstream on CMAKE help
src_configure() {
	CMAKE_BUILD_TYPE=Release
	cmake_src_configure
}
