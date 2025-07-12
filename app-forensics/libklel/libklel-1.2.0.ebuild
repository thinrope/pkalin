# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A system baselining and evidence collection tool"
HOMEPAGE="https://github.com/KoreLogicSecurity/libklel"
SRC_URI="https://github.com/KoreLogicSecurity/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz "
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {

	econf \
		--disable-silent-rules --disable-static
}

src_install() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
	rm ${D}/usr/lib64/*.la
	einstalldocs
}
