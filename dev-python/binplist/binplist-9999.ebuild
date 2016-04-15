# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Binary property list (plist) parser"
HOMEPAGE="https://github.com/google/binplist"
SRC_URI=""
EGIT_REPO_URI="https://github.com/google/binplist.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/binplist"
EGIT_COMMIT="HEAD"
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=dev-python/pytz-2015.6"
RDEPEND="${DEPEND}"
