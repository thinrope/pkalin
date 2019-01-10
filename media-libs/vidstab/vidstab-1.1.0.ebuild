# Copyright 2018-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils toolchain-funcs

DESCRIPTION="Video stabilization library"
HOMEPAGE="http://public.hronopik.de/vid.stab/"
SRC_URI="https://github.com/georgmartius/vid.stab/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openmp cpu_flags_x86_sse2"

S="${WORKDIR}/vid.stab-${PV}"
src_prepare() {
	# USE=cpu_flags_x86_sse2 instead
	sed -e 's#include (FindSSE)##' -i CMakeLists.txt
	# strip -O3 -g CFLAGS
	for FILE_TO_PATCH in {,transcode/,tests/}CMakeLists.txt; do
		sed -E 's#(add_definitions.* )-g #\1#' -i ${FILE_TO_PATCH}
		sed -E 's#(add_definitions.* )-O3 #\1#' -i ${FILE_TO_PATCH}
	done
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
