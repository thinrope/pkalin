# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="INDXParse: Tool suite for inspecting NTFS artifacts"
HOMEPAGE="https://github.com/williballenthin/INDXParse"
SRC_URI=""
EGIT_REPO_URI="https://github.com/williballenthin/INDXParse"
EGIT_COMMIT="HEAD"
EGIT_CHECKOUT_DIR="${WORKDIR}/INDXParse"
S="${WORKDIR}/INDXParse"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	dev-python/wxpython:*
	>=dev-python/jinja-2.8
	>=dev-python/fuse-python-0.2.1-r1"

RDEPEND="${DEPEND}"
