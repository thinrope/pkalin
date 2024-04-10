# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_EXT=1

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Python bindings for The Sleuthkit (libtsk)"
HOMEPAGE="https://github.com/py4n6/pytsk/"
SRC_URI="https://github.com/py4n6/${PN}/releases/download/${PV}/${PN}3-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="aff ewf zlib java debug"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=">=app-forensics/sleuthkit-4.11[aff=,ewf=,zlib=,java=]
	sys-libs/talloc[python]
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}3-${PV}"

distutils_enable_tests setup.py
