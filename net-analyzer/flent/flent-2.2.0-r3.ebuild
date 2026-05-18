# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 xdg

DESCRIPTION="The FLExible Network Tester"
HOMEPAGE="https://flent.org/"
SRC_URI="https://github.com/tohojo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui"

PATCHES="
	${FILESDIR}/${P}-fix-deprecated-QDockWidget-AllDockWidgetFeatures.patch
	${FILESDIR}/${P}-Update-backend-for-matplotlib-3.10.patch
"

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

DOCS=( BUGS CHANGES.md README.rst batchfile.example flent-paper.batch flentrc.example misc/ )

distutils_enable_tests unittest
