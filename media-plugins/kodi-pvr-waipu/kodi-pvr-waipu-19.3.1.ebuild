# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="Kodi's waipu.tv PVR client addon"
HOMEPAGE="https://github.com/flubshi/pvr.waipu"

case ${PV} in
9999)
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/flubshi/pvr.waipu.git"
	inherit git-r3
	;;
*)
	CODENAME="Matrix"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/flubshi/pvr.waipu/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/pvr.waipu-${PV}-${CODENAME}"
	;;
esac

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	=media-tv/kodi-19*
	dev-libs/jsoncpp
	=media-plugins/kodi-inputstream-adaptive-19*
	dev-python/PySocks
	"

RDEPEND="${DEPEND}"
