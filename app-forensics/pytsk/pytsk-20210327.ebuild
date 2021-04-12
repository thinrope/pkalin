# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,9} )

inherit distutils-r1

DESCRIPTION="Python bindings for Sleuthkit"
HOMEPAGE="https://github.com/py4n6/pytsk/"
SRC_URI="https://github.com/py4n6/${PN}/releases/download/${PV}/${PN}3-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=">=app-forensics/sleuthkit-4.10
	sys-libs/talloc
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}3-${PV}"
