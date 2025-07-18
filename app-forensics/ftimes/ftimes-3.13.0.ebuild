# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A system baselining and evidence collection tool"
HOMEPAGE="http://ftimes.sourceforge.net/FTimes/"
SRC_URI="https://master.dl.sourceforge.net/project/${PN}/${PN}/${PV}/${P}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcre ssl static"

DEPEND=">=sys-libs/zlib-1.2.8
	>=app-arch/bzip2-1.0.6
	>=app-forensics/libklel-1.2.0
	ssl? ( >=dev-libs/openssl-1.0.2d )
	pcre? ( >=dev-libs/libpcre-8.36 )"

src_configure() {
	use static && sed -i -e "s/^FTIMES_LFLAGS.*/& -static/" "${S}/src/Makefile.in"
	# TODO:
	#	add more useflags
	#	see how to install the server
	econf \
		$(use_with ssl ssl /usr) \
		$(use_with pcre pcre /usr)
}

src_install() {
	emake DESTDIR="${D}" install
	# FIXME: ugly!
	mkdir "${D}/etc"
	mv "${D}/usr/man" "${D}/usr/share/"
	mv "${D}/usr/etc" "${D}/etc/${PN}"
}
