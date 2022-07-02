# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="SIMONW"
DIST_VERSION="0.4"

inherit perl-module

DESCRIPTION="File::Mork - a module to read Mozilla URL history files"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"

DEPEND="dev-perl/HTML-Parser
	dev-lang/perl"
BDEPEND="dev-perl/Module-Build"

src_prepare() {
	default
}

src_configure() {
	perl-module_src_configure
}

src_install() {
	perl-module_src_install
}
