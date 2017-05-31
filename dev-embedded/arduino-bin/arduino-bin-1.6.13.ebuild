# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="An open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/"
SRC_URI="https://downloads.arduino.cc/arduino-${PV}-linux64.tar.xz"
LICENSE="GPL-2 LGPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip binchecks fetch"
IUSE=""

RDEPEND="!!dev-embedded/arduino
	dev-java/oracle-jdk-bin:1.8"
DEPEND="${RDEPEND}"

S="${WORKDIR}/arduino-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-script.patch"
}

src_install() {
	exeinto "/usr/bin"
	doexe arduino

	dodir /usr/share/arduino
	for IF in arduino-builder examples hardware lib libraries reference tools tools-builder
	do
		cp -R "${S}/${IF}" "${D}/usr/share/arduino/${IF}"
	done
	chown -R root:root "${D}/usr/share/arduino/"
}

pkg_postinst() {
	einfo
	einfo "This is a binary package and includes the full toolchain."
	einfo "For Leonardo/Micro support, make sure CONFIG_USB_ACM is"
	einfo "enabled in your running kernel!"
	einfo
}
