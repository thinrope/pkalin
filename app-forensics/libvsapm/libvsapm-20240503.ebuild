# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
inherit autotools python-single-r1

DESCRIPTION="Library and tools to access the Apple Partition Map (APM) volume system format"
HOMEPAGE="https://github.com/libyal/libvsapm"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-experimental-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="python debug"

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"

DEPEND="
	python? ( dev-lang/python:* )
"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable python)
}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}
