# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 xdg git-r3

DESCRIPTION="The FLExible Network Tester"
HOMEPAGE="https://flent.org/"
EGIT_REPO_URI="https://github.com/tohojo/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	gui? (
		>=dev-python/matplotlib-3.10.0[${PYTHON_USEDEP}]
		dev-python/pyqt6[${PYTHON_USEDEP}] )
	net-analyzer/netperf[demo]
	net-misc/iperf
	net-analyzer/fping
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

src_prepare () {
	default
	sed -i -e "s#share/doc/${PN}#share/doc/${PF}#g" setup.py || die "Sed failed!"
}
