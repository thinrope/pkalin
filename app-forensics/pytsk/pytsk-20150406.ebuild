# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit versionator distutils-r1

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Python bindings for Sleuthkit"
HOMEPAGE="https://github.com/py4n6/pytsk/"
SRC_URI="https://github.com/py4n6/${PN}/releases/download/${MY_DATE}/${PN}-${MY_DATE}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=">=app-forensics/sleuthkit-4.1.3-r3
	sys-libs/talloc
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
