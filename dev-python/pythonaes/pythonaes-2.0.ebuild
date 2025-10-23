# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit git-r3 distutils-r1

DESCRIPTION="Pure Python implementation of AES (fork of)"
HOMEPAGE="https://github.com/serprex/pythonaes"
EGIT_REPO_URI="https://github.com/serprex/${PN}.git"
EGIT_OVERRIDE_COMMIT_CERT_EE_PEEPDF="199906935b8336902b1f552d5570363dfa7ff110" # 2023-09-23

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests unittest
