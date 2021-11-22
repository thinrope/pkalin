# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools toolchain-funcs

DESCRIPTION="A network sniffer for DNS server replies"
HOMEPAGE="https://github.com/gamelinux/passivedns"
SRC_URI=""
EGIT_REPO_URI="https://github.com/gamelinux/passivedns"

if [[ ${PV} != *9999 ]] ; then
	EGIT_COMMIT="${PV}"
	PATCHES="${FILESDIR}/${PN}-1.2.1_gcc10.patch"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=net-libs/ldns-1.7.1-r5
		>=net-libs/libpcap-1.10.0-r1"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	if [[ $(declare -p PATCHES 2>/dev/null) == "declare -a"* ]]; then
		[[ -n ${PATCHES[@]} ]] && eapply "${PATCHES[@]}"
	else
		[[ -n ${PATCHES} ]] && eapply ${PATCHES}
	fi
	eapply_user
}

src_compile() {
	cd "${S}/src"
	emake
}

src_install() {
	cd "${S}/src"
	dobin passivedns
	dodoc -r "${S}/doc"
}
