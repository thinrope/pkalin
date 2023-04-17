# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3

DESCRIPTION="Nifty scrips for gentoo that go under /usr/local/{,s}bin"
HOMEPAGE="https://github.com/thinrope/gentoo-nifty-scripts"
EGIT_REPO_URI="https://github.com/thinrope/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="+i18n"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-vcs/git"
RDEPEND="${DEPEND}
	app-portage/eix
	app-admin/perl-cleaner
	app-portage/gentoolkit
	i18n? (
		app-text/convmv
		app-arch/p7zip )
	sys-apps/util-linux
	sys-apps/coreutils
	sys-devel/bc"

src_install() {
	exeinto /usr/local/sbin
	doexe usr/local/sbin/update-gentoo.sh
	doexe usr/local/sbin/device_confirm_blank.sh
	doexe usr/local/sbin/device_make_blank.sh
	exeinto /usr/local/bin
	doexe usr/local/bin/jzip
	doexe usr/local/bin/FTKI_deuglify.pl
	doexe usr/local/bin/suc
}
