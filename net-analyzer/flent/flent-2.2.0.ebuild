# Copyright 1999-2025 Gentoo Authors
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
IUSE="+gui +plots"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	plots? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
	gui? ( dev-python/pyqt5[${PYTHON_USEDEP}]
			=dev-python/qtpy-2.4.3_pre99[${PYTHON_USEDEP}]
		)
	net-analyzer/netperf[demo]
	net-misc/iperf
	net-analyzer/fping
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
