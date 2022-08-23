# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic eutils

DESCRIPTION="IBM's open source, high performance Java compiler"
HOMEPAGE="http://jikes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="IBM"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
DEPEND=""
RDEPEND=">=dev-java/java-config-2.0.0"

src_prepare() {
	epatch "${FILESDIR}"/deprecated.patch
	default
}

src_configure() {
	filter-flags "-fno-rtti"
	econf || die "configure problem"
}

src_install () {
	make DESTDIR="${D}" install || die "install problem"
	dodoc ChangeLog AUTHORS README TODO NEWS

	mv "${D}"/usr/bin/jikes{,-bin}
	dobin "${FILESDIR}"/jikes

	insinto /usr/share/java-config-2/compiler
	newins "${FILESDIR}"/compiler-settings jikes
}
