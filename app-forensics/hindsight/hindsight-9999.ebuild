# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 git-r3

DESCRIPTION="Internet history forensics for Google Chrome/Chromium"
HOMEPAGE="https://github.com/obsidianforensics/hindsight"
SRC_URI=""
EGIT_REPO_URI="https://github.com/obsidianforensics/hindsight"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64"
else
	EGIT_COMMIT="HEAD"
	KEYWORDS=""
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=dev-python/bottle-0.12.18
	>=dev-python/keyring-21.2.1
	>=dev-python/pycryptodome-3.9.7
	>=dev-python/pytz-2021.3
	>=dev-python/xlsxwriter-3.0.1
	>=dev-python/puremagic-1.11"
RDEPEND="${DEPEND}"
