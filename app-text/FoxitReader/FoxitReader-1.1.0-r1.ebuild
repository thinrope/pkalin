# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="A free, closed-source PDF document viewer (not supported anymore, 32bit)"
HOMEPAGE="http://www.foxitsoftware.com/products/pdf-reader/"
SRC_URI="http://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/1.x/1.1/enu/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND="
	>=dev-libs/atk-2.16.0-r1[abi_x86_32(-)]
	>=dev-libs/expat-2.1.0-r5[abi_x86_32(-)]
	>=dev-libs/glib-2.44.1:2[abi_x86_32(-)]
	>=dev-libs/gmp-5.1.3-r1:0[abi_x86_32(-)]
	>=dev-libs/libtasn1-4.5[abi_x86_32(-)]
	>=dev-libs/nettle-2.7.1-r4[abi_x86_32(-)]
	>=media-gfx/graphite2-1.2.4-r1[abi_x86_32(-)]
	>=media-libs/freetype-2.5.5:2[abi_x86_32(-)]
	>=net-print/cups-2.0.3[abi_x86_32(-)]
	>=virtual/libffi-3.0.13-r1[abi_x86_32(-)]
	>=x11-libs/cairo-1.14.2[abi_x86_32(-)]
	>=x11-libs/gtk+-2.24.28-r1:2[abi_x86_32(-)]
	>=x11-libs/libXxf86vm-1.1.4[abi_x86_32(-)]
	>=x11-libs/libdrm-2.4.59[abi_x86_32(-)]
	>=x11-libs/libxshmfence-1.2[abi_x86_32(-)]
	>=x11-libs/pango-1.36.8[abi_x86_32(-)]
"
# NOTE: The above RDEPEND is the result of the following painfull circular process (gcc/glibc can be ignored):
#
# ldd /var/tmp/portage/app-text/FoxitReader-1.1.0/image/opt/FoxitReader/FoxitReader |cut -d">" -f  2|cut -d " " -f 2|grep "^/"|xargs -n1 equery b|sort -u >linked
# cat FoxitReader-1.1.0.ebuild |perl -ne 'print "$1\n" if (m#\s+\>=([^\[]*)#);' |xargs equery -C depgraph -lUMA --depth=1|perl -ne 'print if (s#^[ \[\]0-9]+##);'| sort -u >ebuild
# for i in $(cat linked); do grep -q $i ebuild || echo "$i not found"; done
#

QA_PRESTRIPPED="/opt/FoxitReader/FoxitReader"
S=${WORKDIR}/1.1-release

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"
}

src_install() {
	insinto /opt/${PN}
	doins fum.fhd fpdfcjk.bin || die

	insopts -m755
	doins ${PN} || die

	make_wrapper ${PN} ./${PN} /opt/${PN}
	doicon "${FILESDIR}"/${PN}.png || die
}
