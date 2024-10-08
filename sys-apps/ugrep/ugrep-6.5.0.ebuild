# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="A fast, drop-in replacement for GNU grep"
HOMEPAGE="https://ugrep.com/"
SRC_URI="https://github.com/Genivia/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="7z brotli boost +bzip2 bzip3 cpu_flags_arm_neon cpu_flags_x86_avx2 cpu_flags_x86_sse2 +lzma lz4 +mmap +pcre test +zlib zstd"

COMMON_DEPEND="
	brotli? ( app-arch/brotli )
	boost? ( dev-libs/boost )
	bzip2? ( app-arch/bzip2 )
	bzip3? ( app-arch/bzip3 )
	lz4? ( app-arch/lz4 )
	lzma? ( app-arch/xz-utils )
	pcre? ( dev-libs/libpcre2 )
	zlib? ( sys-libs/zlib )
	zstd? ( app-arch/zstd )
"

RDEPEND="${COMMON_DEPEND}"

DEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig"

RESTRICT="!test? ( test )"

src_configure() {
	local myeconfargs=(
		$(use_enable cpu_flags_x86_avx2 avx2)
		$(use_enable cpu_flags_x86_sse2 sse2)
		$(use_enable cpu_flags_arm_neon neon)
		$(use_enable 7z 7zip)
		$(use_enable mmap)
		$(use_with pcre pcre2)
		$(use_with boost boost-regex)
		$(use_with zlib)
		$(use_with bzip2 bzlib)
		$(use_with lzma)
		$(use_with lz4)
		$(use_with zstd)
		$(use_with brotli)
		$(use_with bzip3)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	dobashcomp "${S}"/completions/bash/*
	dofishcomp "${S}"/completions/fish/*
	dozshcomp "${S}"/completions/zsh/_*
}

src_test() {
	# emake check is run first by default in Portage but
	# that doesn't actually run the tests, emake test does
	emake test
}
