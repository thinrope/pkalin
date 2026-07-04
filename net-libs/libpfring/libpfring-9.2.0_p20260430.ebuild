# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

MY_PN="PF_RING"	# upstream calls it this way
MY_PV=$(ver_cut 1-3) # ignore the _p<DATE> version suffix
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="PF_RING: High-speed packet processing framework (libpfring)"
HOMEPAGE="https://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI="https://github.com/ntop/${MY_PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}/userland"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-kernel/linux-headers
	sys-process/numactl"
RDEPEND="${DEPEND}
	~sys-kernel/pf_ring-kmod-${PV}"
BDEPEND="dev-vcs/git"	# for `git apply` patching, see BGO #835964

# Patches updated for 9.2.0_p20260430
src_prepare() {
	local GIT_PATCHES=(
		"${FILESDIR}/0001-Fix-symm-rss-conf-in-ice-driver.patch"
		"${FILESDIR}/0002-Fix-call-to-ice_add_rss_list-to-avoid-resetting-symm.patch"
		"${FILESDIR}/0003-Fix-compilation-on-RH9.7.patch"
		"${FILESDIR}/0004-Fix-ixgbe-compilation-on-RH9.7.patch"
		"${FILESDIR}/0005-Fix-i40e-compilation-on-RH9.7.patch"
		"${FILESDIR}/0006-Fix-race-condition-with-bond-interfaces.patch"
		"${FILESDIR}/0007-Update-ZC-libs.patch"
		"${FILESDIR}/0008-Compilation-fix-on-kernel-6.17.patch"
		"${FILESDIR}/0009-Update-libs.patch"
	)
	cd "${WORKDIR}/${MY_P}"
	for GIT_PATCH in "${GIT_PATCHES[@]}"
	do
		einfo "Applying git patch: ${GIT_PATCH} ..."
		git apply "${GIT_PATCH}"
	done
	default_src_prepare
}

src_configure() {
	set -- "${S}/configure" \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--mandir="${EPREFIX}/usr/share/man" \
	echo "${@}"
	"${@}" || die
}

src_compile() {
	MAKEOPTS=-j1
	emake ${PN}
}

src_install() {
	cd lib/
	emake DESTDIR="${D}" install-includes
	default
	# FIXME: Do we need to install nbpftest
}
