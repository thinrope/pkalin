# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Digital Forensics Windows Registry (dfWinReg)"
HOMEPAGE="https://github.com/log2timeline/dfwinreg"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-python/pip-7.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/dfdatetime-20160814
	>=dev-python/dtfabric-20170524
	>=dev-libs/libcreg-20210502[python]
	>=app-forensics/libregf-20201002[python]
	>=dev-python/pyxattr-0.7.2[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
	test? (
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pbr-4.2.0[${PYTHON_USEDEP}]
		>=dev-python/six-1.1.0[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

python_test() {
	"${EPYTHON}" run_tests.py -v || die
}

python_install_all() {
	distutils-r1_python_install_all
}
