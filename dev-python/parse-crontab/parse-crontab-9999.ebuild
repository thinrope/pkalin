# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1 git-r3

DESCRIPTION="Python bindings for ssdeep"
HOMEPAGE="https://github.com/josiahcarlson/parse-crontab"
EGIT_REPO_URI="https://github.com/josiahcarlson/parse-crontab.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
