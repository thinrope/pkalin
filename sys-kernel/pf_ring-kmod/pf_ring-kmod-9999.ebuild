# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit linux-mod linux-info subversion

ESVN_REPO_URI="https://svn.ntop.org/svn/ntop/trunk/PF_RING/"

DESCRIPTION="A new type of network socket that improves packet capture speed."
HOMEPAGE="http://www.ntop.org/PF_RING.html"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-kernel/linux-headers
"
RDEPEND=""

CONFIG_CHECK="NET"
ERROR_NET="PF_RING requires CONFIG_NET=y set in the kernel."
BUILD_TARGETS="modules"

pkg_setup() {
	if [[ ${PV} == *9999* ]]; then
		elog
		elog "This is a live ebuild which installs the latest from upstream's"
		elog "subversion repository, and is unsupported by Gentoo."
		elog "Everything but bugs in the ebuild itself will be ignored."
		elog
	fi
	linux-mod_pkg_setup
}

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		subversion_src_unpack
		S="${WORKDIR}/${P}/kernel/"
	fi

	MODULE_NAMES="pf_ring(net/pf_ring:${S}:${S})"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} EXTRA_CFLAGS='-I${S}'"
}

src_prepare() {
	local svf=snapshot_version

	cd "${S}"
	if [[ ${PV} = *9999* ]]; then
		# Set SVN version manually
		subversion_wc_info
		printf "${ESVN_WC_REVISION}" > $svf
	fi

	if [ ! -f VERSION ] ; then
		[ -f "$svf" ] || die "Missing ${svf}. Did you generate your snapshot with prepare_PF_RING?"
		local sv=$(<$svf)
		printf "SVN-r${sv} (Gentoo)" > VERSION
	fi
}

src_install() {
	linux-mod_src_install
	insinto /usr/include/linux
	doins linux/pf_ring.h || die
	dodoc "${WORKDIR}/${PF}"/doc/UsersGuide.pdf || die
}

pkg_postinst() {
	einfo "Please see /usr/share/doc/${PF}/README.module_options for configuration options."
	linux-mod_pkg_postinst
}
