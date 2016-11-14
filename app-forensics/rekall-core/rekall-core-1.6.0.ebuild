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
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
# TODO	https://github.com/google/rekall/blob/master/rekall-core/setup.py
# =artifacts-20160114 https://github.com/ForensicArtifacts/artifacts
# =rekall-capstone-3.0.4.post2
# =rekall-yara-3.4.0.1
#
RDEPEND="${DEPEND}
	>=dev-python/pyaff4-0.24
	<dev-python/pyaff4-0.30
	=dev-python/pyyaml-3.11
	=dev-python/acora-2.0
	=dev-python/arrow-0.7.0
	=dev-python/dotty-1.3
	=dev-python/intervaltree-2.1.0
	=dev-python/pycrypto-2.6.1
	=dev-python/pyelftools-0.24
	=dev-python/pyparsing-2.1.5
	=dev-python/pytz-2016.4
	>=dev-python/psutil-4.0
	<dev-python/psutil-5.0
	=dev-python/sortedcontainers-1.4.4
	=app-forensics/pytsk-20160721
	=dev-python/ipaddr-2.1.11
"
