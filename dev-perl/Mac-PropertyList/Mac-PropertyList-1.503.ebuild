# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="BDFOY"
DIST_VERSION="1.503"

inherit perl-module

DESCRIPTION="Mac::PropertyList - work with Mac plists at a low level"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"

DEPEND="dev-perl/XML-Entities
	dev-lang/perl"

src_prepare() {
	default
}

src_configure() {
	perl-module_src_configure
}

src_install() {
	perl-module_src_install
}
