# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils

DESCRIPTION="A system baselining and evidence collection tool"
HOMEPAGE="http://ftimes.sourceforge.net/FTimes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-macos"
IUSE="pcre ssl static"

DEPEND=">=sys-libs/zlib-1.2.8
	>=app-arch/bzip2-1.0.6
	ssl? ( >=dev-libs/openssl-1.0.2d )
	pcre? ( >=dev-libs/libpcre-8.36 )"

src_configure() {
	use static && sed -i -e "s/^FTIMES_LFLAGS.*/& -static/" "${S}/src/Makefile.in"
	# TODO:
	#	add more useflags
	#	see how to install the server
	econf \
		--with-all-tools \
		$(use_with ssl ssl /usr) \
		$(use_with pcre pcre /usr)
}

src_install() {
	emake DESTDIR="${D}" install
	# FIXME: ugly!
	mkdir "${D}/usr/share" "${D}/etc/${PN}"
	mv "${D}/usr/man" "${D}/usr/share/"
	# FIXME: not working?!
	mv "${D}/etc/*" "${D}/etc/${PN}"
}
