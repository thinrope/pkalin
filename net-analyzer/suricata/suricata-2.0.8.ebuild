# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Open Source next generation intrusion detection and prevention engine"
HOMEPAGE="http://openinfosecfoundation.org/"
SRC_URI="http://openinfosecfoundation.org/download/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +pfring +af-packet"

DEPEND="
	>=dev-libs/libpcre-8.36
	>=net-libs/libnet-1.1.6
	>=dev-libs/libyaml-0.1.6
	>=net-libs/libpcap-1.7.4
	>=sys-libs/zlib-1.2.8-r1
	>=sys-process/numactl-2.0.9
	pfring? ( net-libs/libpfring )
"

RDEPEND="${DEPEND}"

src_configure() {
	local myconf="--disable-gccmarch-native"
	filter-flags -O2
	append-cppflags -U_FORTIFY_SOURCE
	append-cppflags -DHAVE_PFRING_OPEN_NEW
	append-libs -lrt -lnuma

	myconf="${myconf} \
	$(use_enable debug) \
	$(use_enable af-packet) \
	$(use_enable pfring) \
	"

	econf ${myconf} || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"

	# install configure files
	insopts -m 600
	insinto /etc/suricata
	doins suricata.yaml || die
	doins classification.config || die
	doins reference.config || die
	doins threshold.config || die

	insinto /var/run
	insinto /var/log/suricata

	insopts -m 600
	insinto /etc/suricata/rules
	doins rules/decoder-events.rules || die
	doins rules/stream-events.rules || die
	doins rules/smtp-events.rules || die
	doins rules/http-events.rules || die
}
