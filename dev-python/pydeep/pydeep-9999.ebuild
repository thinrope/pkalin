# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1 git-r3

DESCRIPTION="Python bindings for ssdeep"
HOMEPAGE="https://github.com/kbandla/pydeep"
EGIT_REPO_URI="https://github.com/kbandla/pydeep.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=">=app-crypt/ssdeep-2.8
${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
