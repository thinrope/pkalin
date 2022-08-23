# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tool for managing windows's LDM partitions"
HOMEPAGE="https://github.com/mdbooth/libldm"
SRC_URI="https://github.com/mdbooth/${PN}/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
DEPEND="dev-util/gtk-doc"

inherit autotools flag-o-matic

src_prepare() {
	# Remove problematic LDFLAGS declaration
	sed -i -e 's/ -Werror//g' src/Makefile.am || die
	eautoreconf
	eapply_user
}

src_unpack() {
	unpack ${A}
	mv "libldm-${P}" "${P}"
}
