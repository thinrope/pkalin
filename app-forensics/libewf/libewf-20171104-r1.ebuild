# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit versionator python-r1

MY_DATE="$(get_version_component_range 1)"
DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="https://github.com/libyal/libewf/"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${MY_DATE}/${PN}-experimental-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/3"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 debug fuse python nls ssl static static-libs unicode uuid zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="mirror"

DEPEND="
	fuse? (
		sys-fs/fuse:0
		static? ( sys-fs/fuse:0[static-libs] )
		)
	uuid? ( >=sys-apps/util-linux-2.16 )
	ssl? (
		dev-libs/openssl:0
		static? ( dev-libs/openssl:0[static-libs] )
		)
	zlib? (
		sys-libs/zlib
		static? ( sys-libs/zlib[static-libs] )
		)
	bzip2? (
		app-arch/bzip2
		static? ( app-arch/bzip2[static-libs] )
		)
	nls? (
		virtual/libintl
		virtual/libiconv
	)
	python? ( ${PYTHON_DEPS} )

	dev-libs/libuna
	app-forensics/libbfio
	dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcaes
	dev-libs/libcdata
	dev-libs/libcdatetime
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcsplit
	dev-libs/libuna
	dev-libs/libcfile
	dev-libs/libcpath
	dev-libs/libfcache
	dev-libs/libfdata
	dev-libs/libfguid
	dev-libs/libfvalue
	dev-libs/libsmdev
"
TOBE_ADDED="
	dev-libs/libodraw
	dev-libs/libsmraw

"
RDEPEND="${DEPEND}"

#https://github.com/libyal/libewf/issues/85
# dev-libs/libcfile must be with libsmdev

TEST="
	ADLER32 checksum support:                 zlib
	DEFLATE compression support:              zlib
	BZIP2 compression support:                bzip2
	libhmac support:                          local
	MD5 support:                              libcrypto_evp
	SHA1 support:                             libcrypto_evp
	SHA256 support:                           libcrypto_evp
	AES support:                              libcrypto_evp
"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS ChangeLog NEWS README )

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local myconf=(
		--disable-rpath
		--enable-multi-threading-support
		--with-libbfio
		$(use_enable static static-executables)
		$(use_enable static-libs static)
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
		$(use_enable python)
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_with zlib)
		$(use_with bzip2)
		$(use_with ssl openssl)
		$(use_with uuid libuuid)
		$(use_with fuse libfuse)
	)

	if use python ; then
		#todo: make python2 optional
		myconf+=( --enable-python2 )
		prepare_python() {
			if python_is_python3; then
				myconf+=( --enable-python3 )
			fi
		}
		python_foreach_impl run_in_build_dir prepare_python
	fi

	econf ${myconf[@]}
}
