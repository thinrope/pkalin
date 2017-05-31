# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit	eutils

DESCRIPTION="CUPS drivers for XEROX printers (ApeosPort-V, DocuCentre-V, DocuPrint)"
HOMEPAGE="https://www.fujixerox.co.jp/download/docuprint/download/p450d/linux64/"
SRC_URI="http://download.fujixerox.co.jp/pub/exe/apeosport/c4300series/${PN}-src-${PV}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-src-${PV}"

src_prepare() {
	eapply_user
	epatch "${FILESDIR}/${PN}-${PV}.patch"
}
