# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils

DESCRIPTION="Photo Image Print System Lite (PIPS Lite) provides drivers for Epson inkjet printers"
HOMEPAGE="http://www.avasys.jp/lx-bin2/linux_e/spc/DL1.do"
SRC_URI="${PN}_${PV}-5.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-print/cups
	x11-libs/gtk+"
RDEPEND="${DEPEND}"
RESTRICT="fetch strip"
MAKEOPTS=-j1

pkg_nofetch() {
	einfo "As avasys removed the direct download link, you need to fetch"
	einfo "the pipslite source from ${HOMEPAGE}"
	einfo "After filling out the questionnaire, download file ${A}"
	einfo "and place it into ${DISTDIR}"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	cd "${D}"

	# install the init.d script
	doinitd usr/$(get_libdir)/${PN}/rc.d/pipslited

	# make needed symlinks
	for i in usr/$(get_libdir)/${PN}/* ; do
		dosym /${i} usr/bin/$(echo ${i} | sed -e "s/usr\/$(get_libdir)\/pipslite\///")
	done

	# remove init scripts for other distros
	rm -rf usr/share/pipslite/rc.d

	# remove useless
	#rm -rf var
}

pkg_postinst() {
	einfo "To install a ppd file for your printer, run"
	einfo "     /etc/init.d/pipslited start"
	einfo "     pipslite-install"
}
