# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Rekall Memory Forensic Framework"
HOMEPAGE="http://www.rekall-forensic.com/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/google/rekall.git"
EGIT_COMMIT="v${PV}"
EGIT_CHECKOUT_DIR="${WORKDIR}/rekall"
S="${WORKDIR}/rekall"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
# Todo https://github.com/google/rekall/blob/master/rekall-gui/setup.py
# dev-python/flask-sockets	https://pypi.python.org/pypi/Flask-Sockets
# >=dev-python/codegen-1.0	https://pypi.python.org/pypi/codegen

RDEPEND="${DEPEND}
	~app-forensics/rekall-core-${PV}
	dev-python/flask
	>=dev-python/gevent-1.0.2
	>=dev-python/gevent-websocket-0.9.3
"
