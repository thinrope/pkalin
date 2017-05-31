# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Editable interval tree data structure for Python 2 and 3"
HOMEPAGE="https://github.com/chaimleib/intervaltree"
SRC_URI=""
EGIT_REPO_URI="https://github.com/chaimleib/intervaltree.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/intervaltree"
EGIT_COMMIT="HEAD"
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/sortedcontainers-0.9.6"
