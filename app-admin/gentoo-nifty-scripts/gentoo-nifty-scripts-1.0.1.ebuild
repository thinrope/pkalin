# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Nifty scrips for Gentoo that go under /usr/local/{,s}bin"
HOMEPAGE="https://github.com/thinrope/gentoo-nifty-scripts"
SRC_URI="https://github.com/thinrope/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=app-admin/perl-cleaner-2.31
	>=app-arch/p7zip-17.05-r1
	>=app-crypt/md5deep-4.4
	>=app-misc/colordiff-1.0.21
	>=app-portage/eix-0.36.7
	>=app-text/convmv-2.05-r1
	>=sys-apps/coreutils-9.7
	>=sys-apps/hdparm-9.65-r2
	>=sys-apps/pv-1.8.12
	>=sys-apps/smartmontools-7.4-r1
	>=sys-apps/util-linux-2.41.1-r1
	>=sys-devel/bc-1.08.2
	>=sys-libs/glibc-2.38-r11
"

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
