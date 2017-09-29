# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic eutils user

DESCRIPTION="High performance Network IDS, IPS and Network Security Monitoring engine"
HOMEPAGE="http://suricata-ids.org/"
SRC_URI="http://www.openinfosecfoundation.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+af-packet control-socket cuda debug +detection geoip hardened logrotate lua luajit nflog +nfqueue +pfring redis +rules test"

DEPEND="
	>=dev-libs/jansson-2.9
	>=dev-libs/libpcre-8.40
	>=dev-libs/libyaml-0.1.7
	>=net-libs/libnet-1.1.6
	>=net-libs/libnfnetlink-1.0.1
	dev-libs/nspr
	dev-libs/nss
	>=net-libs/libhtp-0.5.20
	net-libs/libpcap
	sys-apps/file
	cuda?       ( dev-util/nvidia-cuda-toolkit )
	geoip?      ( dev-libs/geoip )
	lua?        ( dev-lang/lua:* )
	luajit?     ( dev-lang/luajit:* )
	nflog?      ( net-libs/libnetfilter_log )
	nfqueue?    ( net-libs/libnetfilter_queue )
	redis?      ( dev-libs/hiredis )
	logrotate?      ( app-admin/logrotate )
	sys-libs/libcap-ng
	pfring?     ( net-libs/libpfring )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} "${PN}"
}

src_configure() {
	local myeconfargs=( "--localstatedir=/var/" "--enable-non-bundled-htp" )
	use af-packet && myeconfargs+=( $(use_enable af-packet) )
	use detection && myeconfargs+=( $(use_enable detection) )
	use nfqueue && myeconfargs+=( $(use_enable nfqueue) )
	use test && myeconfargs+=( $(use_enable test coccinelle) $(use_enable test unittests) )
	use control-socket && myeconfargs+=( $(use_enable control-socket unix-socket) )
	use cuda && myeconfargs+=( $(use_enable cuda) )
	use geoip && myeconfargs+=( $(use_enable geoip) )
	use hardened && myeconfargs+=( $(use_enable hardened gccprotect) )
	use nflog && myeconfargs+=( $(use_enable nflog) )
	use redis && myeconfargs+=( $(use_enable redis hiredis) )
	use pfring && myeconfargs+=( $(use_enable pfring) )
	use lua && myeconfargs+=( $(use_enable lua) )
	use luajit && myeconfargs+=( $(use_enable luajit) )

	if use pfring ; then
		append-cppflags -DHAVE_PFRING_OPEN_NEW
		append-libs -lrt -lnuma
	fi
	if use debug ; then
		myeconfargs+=( $(use_enable debug) )
		# so we can get a backtrace according to "reporting bugs" on upstream web site
		append-cflags "-ggdb -O0"
	fi
	econf ${myeconfargs[@]}
}

src_install() {
	einstall || die "install failed"

	insinto "/etc/${PN}"
	insopts -m 600
	doins {classification,reference,threshold}.config suricata.yaml

	if use rules ; then
		insinto "/etc/${PN}/rules"
		doins rules/*.rules
	fi

	dodir "/var/lib/${PN}"
	dodir "/var/log/${PN}"

	#fowners -R ${PN}: "/var/lib/${PN}" "/var/log/${PN}" "/etc/${PN}"
	#fperms 750 "/var/lib/${PN}" "/var/log/${PN}" "/etc/${PN}"

	newinitd "${FILESDIR}/${P}-init" ${PN}
	newconfd "${FILESDIR}/${P}-conf" ${PN}

	if use logrotate; then
		insopts -m 0644
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/${PN}-logrotate ${PN}
	fi
}

pkg_postinst() {
	elog "The ${PN} init script expects to find the path to the configuration"
	elog "file as well as extra options in /etc/conf.d."
	elog ""
	elog "To create more than one ${PN} service, simply create a new .yaml file for it"
	elog "then create a symlink to the init script from a link called"
	elog "${PN}.foo - like so"
	elog "   cd /etc/${PN}"
	elog "   ${EDITOR##*/} suricata-foo.yaml"
	elog "   cd /etc/init.d"
	elog "   ln -s ${PN} ${PN}.foo"
	elog "Then edit /etc/conf.d/${PN} and make sure you specify sensible options for foo."
	elog ""
	elog "You can create as many ${PN}.foo* services as you wish."

	if use logrotate; then
		elog "You enabled the logrotate USE flag. Please make sure you correctly set up the ${PN} logrotate config file in /etc/logrotate.d/."
	fi

	if use debug; then
		elog "You enabled the debug USE flag. Please read this link to report bugs upstream:"
		elog "https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Reporting_Bugs"
		elog "You need to also ensure the FEATURES variable in make.conf contains the"
		elog "'nostrip' option to produce useful core dumps or back traces."
	fi
}
