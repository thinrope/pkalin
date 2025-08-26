# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Kodi's waipu.tv PVR client addon"
HOMEPAGE="https://github.com/flubshi/pvr.waipu"

CODENAME="Omega"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/flubshi/pvr.waipu/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pvr.waipu-${PV}-${CODENAME}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	media-tv/kodi
	>=dev-libs/rapidjson-1.1.1
	media-plugins/kodi-inputstream-adaptive
"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-D CMAKE_INSTALL_LIBDIR=/usr/lib64/kodi
	)
	cmake_src_configure
}
