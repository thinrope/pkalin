# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="An open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/"
SRC_URI="arduino-${PV}-linux64.tar.xz"
# FIXME: add 32bit support
LICENSE="GPL-2 LGPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip binchecks fetch"
IUSE=""

RDEPEND="!!dev-embedded/arduino
	dev-java/oracle-jdk-bin:1.8"
DEPEND="${RDEPEND}"

S="${WORKDIR}/arduino-${PV}"
AVR_VERSION="4.8.1"

src_prepare() {
	epatch "${FILESDIR}/${P}-script.patch"
}

src_install() {
	exeinto "/usr/bin"
	doexe arduino

	ARD="/usr/share/arduino"
	insinto "${ARD}"
	doins -r hardware
	fperms 0755 ${ARD}/hardware/tools/avr/libexec/gcc/avr/${AVR_VERSION}/cc1{,plus}
	fperms 0755 ${ARD}/hardware/tools/avr/libexec/gcc/avr/${AVR_VERSION}/collect2
	fperms -R 0755 ${ARD}/hardware/tools/avr/bin/
	fperms -R 0755 ${ARD}/hardware/tools/avr/avr/bin/

	doins -r libraries lib dist
	fowners -R root:uucp "${ARD}/hardware"
}

pkg_postinst() {
	einfo
	einfo "This is a binary package and includes the full toolchain."
	einfo "For Leonardo/Micro support, make sure CONFIG_USB_ACM is"
	einfo "enabled in your running kernel!"
	einfo
}
