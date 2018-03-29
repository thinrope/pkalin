# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools wxwidgets git-r3

DESCRIPTION="WoeUSB: create Windows install USB from an iso image or DVD"
HOMEPAGE="https://github.com/slacka/WoeUSB"
EGIT_REPO_URI="https://github.com/slacka/WoeUSB"
EGIT_BRANCH="master"
EGIT_TAG="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/wxGTK:*"
RDEPEND="${DEPEND}
	sys-boot/grub:2[grub_platforms_pc]
	sys-fs/dosfstools
	sys-apps/findutils
	sys-apps/grep
	sys-block/parted
	sys-apps/util-linux
	sys-fs/ntfs3g
	app-arch/p7zip"
# sys-auth/polkit "For calling woeusb as root from woeusbgui" ??

src_prepare () {
	sed -i -e "s/@@WOEUSB_VERSION@@/${PV}/" configure.ac src/woeusb*
	eautoreconf
	eapply_user
}
