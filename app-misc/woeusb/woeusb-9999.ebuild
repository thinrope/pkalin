# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools wxwidgets git-r3

DESCRIPTION="WoeUSB: create Windows install USB from an iso image or DVD"
HOMEPAGE="https://github.com/slacka/WoeUSB"
EGIT_REPO_URI="https://github.com/slacka/WoeUSB"
EGIT_BRANCH="master"
EGIT_TAG="HEAD"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/wxGTK:*"
RDEPEND="${DEPEND}
	sys-boot/grub:2[grub_platforms_pc]"

src_prepare () {
	"${S}/setup-development-environment.bash"
	eautoreconf
	eapply_user
}
