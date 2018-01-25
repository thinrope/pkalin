# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Internet history forensics for Google Chrome/Chromium"
HOMEPAGE="https://github.com/obsidianforensics/hindsight"
SRC_URI=""
EGIT_REPO_URI="https://github.com/obsidianforensics/hindsight"
EGIT_COMMIT="v${PV}"
#EGIT_CHECKOUT_DIR="${WORKDIR}/INDXParse"
#S="${WORKDIR}/INDXParse"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=dev-python/keyring-9.0
	>=dev-python/pytz-2016.4
	>=dev-python/pycryptodome-3.4.3
	>=dev-python/xlsxwriter-0.8.4
	>=dev-python/bottle-0.12.9"

RDEPEND="${DEPEND}"
