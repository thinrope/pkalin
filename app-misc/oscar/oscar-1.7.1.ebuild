# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit qmake-utils

DESCRIPTION="Software used to analyze data from CPAP machines"
HOMEPAGE="https://www.sleepfiles.com/OSCAR/"
SRC_URI="https://gitlab.com/CrimsonNape/OSCAR-code/-/archive/v${PV}/OSCAR-code-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64"

IUSE="debug"

DEPEND="
	virtual/opengl
	x11-libs/libX11
	dev-qt/qtbase:6[gui,opengl,widgets]
	dev-qt/qtserialport:6
	dev-qt/qttools:6
	virtual/glu
	virtual/libudev
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/OSCAR-code-v${PV}"

src_prepare() {
	default
	cd "${S}"
	eqmake6 OSCAR_QT.pro
}

src_install() {
	cd "${S}/oscar"
	dobin OSCAR || die
	dodoc ../README || die
	dodoc docs/* || die
	insinto /usr/share/OSCAR/Html/
	doins docs/{about,credits,release_notes}.html
}
