# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Baseline compliance content in SCAP formats"
HOMEPAGE="http://www.open-scap.org/security-policies/scap-security-guide"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OpenSCAP/scap-security-guide"
EGIT_COMMIT="HEAD"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=app-forensics/openscap-1.2.5
	app-arch/rpm
	dev-libs/libxslt"
RDEPEND="${DEPEND}"
