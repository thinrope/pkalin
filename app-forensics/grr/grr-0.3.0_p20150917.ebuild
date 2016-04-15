# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="GRR Rapid Response is an Incident Response Framework"
HOMEPAGE="https://github.com/google/grr"
SRC_URI=""

EGIT_REPO_URI="https://github.com/google/grr.git"
EGIT_COMMIT="49fd562702d97f88050495bddcd27a9ce8dd07f4"
EGIT_CHECKOUT_DIR=${WORKDIR}/${PN}
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=">=app-forensics/sleuthkit-3.2.3
	app-forensics/pytsk
	>dev-python/django-1.4
	dev-python/ipython
	>dev-python/m2crypto-0.21.1
	>=dev-python/psutil-0.6
	dev-python/pymongo
	dev-python/python-dateutil
	dev-python/ipaddr
	app-arch/zip
	net-misc/wget
	>=dev-libs/protobuf-2.6.1-r3
	dev-db/mongodb
	app-admin/apache-tools
	app-arch/deb2targz
	${PYTHON_DEPS}"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/add_Gentoo_distro.patch"
	epatch_user
}
