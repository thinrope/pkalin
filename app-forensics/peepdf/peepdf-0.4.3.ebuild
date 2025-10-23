# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit git-r3 distutils-r1

DESCRIPTION="Python tool to explore PDF files (fork of)"
HOMEPAGE="http://eternal-todo.com/"
EGIT_REPO_URI="https://github.com/cert-ee/${PN}.git"
EGIT_OVERRIDE_COMMIT_CERT_EE_PEEPDF="18dfba1a55651e352b9691d869375ae22d50e646" # 2025-01-22

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=dev-python/jsbeautifier-1.15.1[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.6[${PYTHON_USEDEP}]
	>=dev-python/future-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-11.1.0[${PYTHON_USEDEP}]
	>=dev-python/pythonaes-2.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

distutils_enable_tests unittest
