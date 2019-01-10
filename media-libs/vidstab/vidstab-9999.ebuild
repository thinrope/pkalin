# Copyright 2018-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils toolchain-funcs git-r3

DESCRIPTION="Video stabilization library"
HOMEPAGE="http://public.hronopik.de/vid.stab/"
EGIT_REPO_URI="https://github.com/georgmartius/vid.stab.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="openmp cpu_flags_x86_sse2"

src_prepare() {
	sed -e 's#include (FindSSE)##' -i CMakeLists.txt
	sed -E 's#(add_definitions.* )-O3 #\1#' -i CMakeLists.txt
	sed -E 's#(add_definitions.* )-O3 #\1#' -i transcode/CMakeLists.txt
	sed -E 's#(add_definitions.* )-O3 #\1#' -i tests/CMakeLists.txt
	cmake-utils_src_prepare
}

src_configure() {
	use openmp && tc-check-openmp
	local mycmakeargs=(
		-DUSE_OMP="$(usex openmp)" \
		-DSSE2_FOUND="$(usex cpu_flags_x86_sse2)"
	)
	cmake-utils_src_configure
}
