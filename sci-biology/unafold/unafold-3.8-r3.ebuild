# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Unified Nucleic Acid Folding and hybridization package"
HOMEPAGE="http://mfold.rna.albany.edu/"
SRC_URI="http://dinamelt.bioinfo.rpi.edu/download/${P}.tar.bz2"

LICENSE="unafold"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="custom-cflags +postscript"

DEPEND="postscript? ( >=sci-biology/mfold_util-4.7 )"
RDEPEND="${DEPEND}"

src_prepare() {
	# recommended in README
	use custom-cflags || append-flags -O3

	# version was not updated upstream apparently
	sed \
		-e 's:hybrid (UNAFold) 3.7:hybrid (UNAFold) 3.8:g' \
		-i tests/hybrid.tml || die
	eapply_user
}
