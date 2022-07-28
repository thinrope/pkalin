# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="mfold_util: graphic rendering for UNAFold"
HOMEPAGE="http://www.unafold.org/mfold/software/download-mfold.php"
SRC_URI="http://www.unafold.org/download/${P}.tar.gz"

LICENSE="unafold"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="custom-cflags"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	use custom-cflags || append-flags -O3
	eapply_user
}
