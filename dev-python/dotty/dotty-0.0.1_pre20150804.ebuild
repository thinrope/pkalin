# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$ 

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="EFILTER Query Language"
HOMEPAGE="https://github.com/google/dotty"
SRC_URI=""
EGIT_REPO_URI="https://github.com/google/dotty.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/dotty"
EGIT_COMMIT="4eebbe7b8fe02f44c5e18c0983402da6297b75b1"
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/python-dateutil-2.2
	>=dev-python/pytz-2015.6"
