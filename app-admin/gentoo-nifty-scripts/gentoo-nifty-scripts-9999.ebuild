# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit git-2

DESCRIPTION="Nifty scrips for gentoo taht go under /usr/local/{,s}bin"
HOMEPAGE="https://github.com/thinrope/gentoo-nifty-scripts"
EGIT_REPO_URI="git://github.com/thinrope/${PN}.git
		https://github.com/thinrope/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS=""

DEPEND="dev-vcs/git"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/demerge
	app-admin/perl-cleaner
	app-admin/python-updater
	app-portage/gentoolkit"

S=${WORKDIR}/${PN}

src_install() {
	exeinto /usr/local/sbin
	doexe usr/local/sbin/update-gentoo.sh || die 'doexe failed'
}
