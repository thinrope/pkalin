# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Rekall Memory Forensic Framework"
HOMEPAGE="http://www.rekall-forensic.com/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/google/rekall.git"
EGIT_COMMIT="v${PV}"
EGIT_CHECKOUT_DIR="${WORKDIR}/rekall"
S="${WORKDIR}/rekall/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/configargparse-0.9.3
	>=dev-python/pyyaml-3.11
	>=dev-python/pytz-2015.6
	>=dev-python/intervaltree-2.0.4
	>=dev-python/pycrypto-2.6.1
	>=dev-python/pyelftools-0.22
	>=dev-libs/distorm64-3.3-r1
	>=dev-python/acora-1.8
	>=dev-python/pyaff4-0.19
	=dev-python/dotty-0.0.1_pre20150804"
