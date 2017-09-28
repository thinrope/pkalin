# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR="BDFOY"
MODULE_VERSION="1.412"

inherit perl-module

DESCRIPTION="Mac::PropertyList - work with Mac plists at a low level"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/XML-Entities
	dev-lang/perl"
