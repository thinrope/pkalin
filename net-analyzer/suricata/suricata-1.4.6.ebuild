# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Open Source next generation intrusion detection and prevention engine"
HOMEPAGE="http://openinfosecfoundation.org/"
SRC_URI="http://openinfosecfoundation.org/download/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug profiling profiling-locks unix-socket prelude nfqueue pfring af-packet dag napatech luajit geoip static-libs"

DEPEND="
	dev-libs/libpcre
	net-libs/libnet
	dev-libs/libyaml
	net-libs/libpcap
	sys-libs/zlib
	app-text/htp
	prelude? (
		dev-libs/libprelude
		app-admin/prelude-manager
		dev-libs/libpreludedb
		app-admin/prelude-lml
	)
	nfqueue? (
		net-libs/libnetfilter_queue
		net-libs/libnfnetlink
	)
	pfring? ( net-libs/libpfring )
	luajit? ( dev-lang/luajit )
	geoip? ( dev-libs/geoip )
"

RDEPEND="${DEPEND}"

src_configure() {
	local myconf=""

	filter-flags -O2
	append-flags -U_FORTIFY_SOURCE
	append-libs -lrt

	if use nfqueue; then
		myconf="${myconf} --enable-nfqueue"
	fi

	if use pfring; then
		myconf="${myconf} --enable-pfring"
	fi

	if use prelude; then
		myconf="${myconf} --enable-prelude"
	fi

	if use luajit; then
		myconf="${myconf} --enable-luajit"
	fi

	if use geoip; then
		myconf="${myconf} --enable-geoip"
	fi

	if use af-packet; then
		myconf="${myconf} --enable-af-packet"
	fi

	if use dag; then
		myconf="${myconf} --enable-dag"
	fi

	if use napatech; then
		myconf="${myconf} --enable-napatech"
	fi

	if use profiling; then
		myconf="${myconf} --enable-profiling"
	fi

	if use profiling-locks; then
		myconf="${myconf} --enable-profiling-locks"
	fi

	if use debug; then
		myconf="${myconf} --enable-debug"
	fi

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

#	emake DESTDIR="${D}" install-full || die "install failed"
}
