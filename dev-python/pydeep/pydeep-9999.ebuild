# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils git-2

DESCRIPTION="Python bindings for ssdeep"
HOMEPAGE="https://github.com/kbandla/pydeep"
EGIT_REPO_URI="https://github.com/kbandla/pydeep.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	app-forensics/ssdeep"
RDEPEND="${DEPEND}"

src_prepare() {
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	python setup.py build
}

src_install() {
	distutils_src_install
}
