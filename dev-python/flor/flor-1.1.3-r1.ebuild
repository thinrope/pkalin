# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A Bloom filter implementation in Python"
HOMEPAGE="https://github.com/DCSO/flor"
SRC_URI="https://github.com/DCSO/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	${FILESDIR}/${P}.patch
)

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests unittest

