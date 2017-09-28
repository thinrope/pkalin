# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR="SIMONW"
MODULE_VERSION="0.4"

inherit perl-module

DESCRIPTION="File::Mork - a module to read Mozilla URL history files"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/Module-Build-0.421.800
	dev-perl/HTML-Parser
	dev-lang/perl"
