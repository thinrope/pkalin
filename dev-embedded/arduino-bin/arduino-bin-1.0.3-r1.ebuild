# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="An open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/ http://arduino.googlecode.com/"
SRC_URI="http://arduino.googlecode.com/files/arduino-${PV}-linux64.tgz"
# FIXME: add 32bit support
LICENSE="GPL-2 LGPL-2 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip binchecks"
IUSE=""

RDEPEND="!!dev-embedded/arduino
>=virtual/jre-1.5"
DEPEND="${RDEPEND}"

S="${WORKDIR}/arduino-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/arduino-${PV}-script.patch
}

src_install() {
	exeinto "/usr/bin"
	doexe arduino

	ARD="/usr/share/arduino"
	insinto "${ARD}"
	doins -r hardware
	fperms 0755 ${ARD}/hardware/tools/avr/lib/gcc/avr/4.3.2/cc1{,plus}
	fperms 0755 ${ARD}/hardware/tools/avr/lib/gcc/avr/4.3.2/collect2
	fperms -R 0755 ${ARD}/hardware/tools/avr/bin/
	fperms -R 0755 ${ARD}/hardware/tools/avr/bin.gcc/
	fperms 0755 ${ARD}/hardware/tools/avrdude{,64}
	# use system avrdude
	#dosym /usr/bin/avrdude "${ARD}/hardware/tools/avrdude"
	#dosym /etc/avrdude.conf "${ARD}/hardware/tools/avrdude.conf"

	insinto "${ARD}"
	doins -r libraries lib
	fowners -R root:uucp "${ARD}/hardware"

}

pkg_postinst() {
	einfo
	einfo "This is a binary package and includes the full toolchain."
	einfo "For Leonardo/Micro support, make sure CONFIG_USB_ACM is"
	einfo "enabled in your running kernel!"
	einfo
}
