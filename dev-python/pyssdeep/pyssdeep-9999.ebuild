# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_COMPAT=( python2_7)
inherit python-r1 subversion

DESCRIPTION="Ssdeep Python bindings"
HOMEPAGE="https://code.google.com/p/pyssdeep/"
ESVN_REPO_URI="http://pyssdeep.googlecode.com/svn/trunk/"
ESVN_PROJECT="pyssdeep-read-only"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=app-forensics/ssdeep-2.0
	dev-python/pyrex"
RDEPEND="${DEPEND}"


src_install() {
	python_export_best
	insinto $(python_get_sitedir)
	doins ${WORKDIR}/${P}/build/lib.linux-x86_64-2.7/ssdeepmodule.so
}
