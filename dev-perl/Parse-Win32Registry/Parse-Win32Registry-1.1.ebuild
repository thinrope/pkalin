# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="JMACFARLA"
DIST_VERSION="1.1"
inherit perl-module

DESCRIPTION="Parse Windows Registry Files"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"

DEPEND="dev-lang/perl"

src_prepare() {
	default
}

src_configure() {
	perl-module_src_configure
}

src_install() {
	perl-module_src_install
}
