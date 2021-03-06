# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Fast multi-keyword search engine for text strings"
HOMEPAGE="https://github.com/scoder/acora"
SRC_URI=""
EGIT_REPO_URI="https://github.com/scoder/acora.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/acora"
EGIT_COMMIT="d115a40f7f5316fb0c13f25514386dbe5b80ee5a"
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
>=dev-python/cython-0.22"
RDEPEND="${DEPEND}"
