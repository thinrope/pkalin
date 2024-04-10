# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A Bloom filter implementation in Python"
HOMEPAGE="https://github.com/DCSO/flor"
HASH_COMMIT=${PV}
SRC_URI="https://github.com/DCSO/${PN}/archive/refs/tags/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests setup.py

