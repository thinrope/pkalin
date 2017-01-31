# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit git-r3

DESCRIPTION="Nifty scrips for gentoo that go under /usr/local/{,s}bin"
HOMEPAGE="https://github.com/thinrope/gentoo-nifty-scripts"
EGIT_REPO_URI="git://github.com/thinrope/${PN}.git
		https://github.com/thinrope/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="dev-vcs/git"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/demerge
	app-admin/perl-cleaner
	app-admin/python-updater
	app-portage/gentoolkit"

src_install() {
	exeinto /usr/local/sbin
	doexe usr/local/sbin/update-gentoo.sh || die 'doexe failed'
}
