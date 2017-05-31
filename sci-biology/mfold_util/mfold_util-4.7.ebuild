# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic

DESCRIPTION="mfold_util: graphic rendering for UNAFold"
HOMEPAGE="http://unafold.rna.albany.edu/?q=mfold/download-mfold"
SRC_URI="http://unafold.rna.albany.edu/download/${P}.tar.gz"

LICENSE="unafold"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="custom-cflags"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	use custom-cflags || append-flags -O3
}
