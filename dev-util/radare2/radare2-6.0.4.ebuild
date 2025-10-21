# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 toolchain-funcs

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="https://www.radare.org"

# Subprojects: NOTE: capstone_v5 is not used, we use dev-libs/capstone
capstone_v5_COMMIT=cd6dd7b75d126a855be1f9f76570ee5a850c6061
# 2.2.2
sdb_COMMIT=a40343ded21d4978b665aa14c913d0b87feb734f
qjs_COMMIT=7238ee64dbc2fbdea044555cda8cda78785a93ed
binaryninja_COMMIT=c40a5f04deec68d388b2072dc42b29141089f9ce
# this will need to be updated?
radare2_testbins_COMMIT=87ab82cc96e83e02f044c0c4111ade2a65576c60

SRC_URI="mirror+https://github.com/radareorg/radare2/archive/${PV}.tar.gz -> ${P}.tar.gz
		mirror+https://github.com/capstone-engine/capstone/archive/${capstone_v5_COMMIT}.tar.gz -> ${P}-capstone_v5.tar.gz
		mirror+https://github.com/radareorg/sdb/archive/${sdb_COMMIT}.tar.gz -> ${P}-sdb.tar.gz
		mirror+https://github.com/quickjs-ng/quickjs/archive/${qjs_COMMIT}.tar.gz -> ${P}-qjs.tar.gz
		mirror+https://github.com/Vector35/binaryninja-api/archive/${binaryninja_COMMIT}.tar.gz -> ${P}-binaryninja.tar.gz
		test? ( https://github.com/radareorg/radare2-testbins/archive/${radare2_testbins_COMMIT}.tar.gz -> radare2_testbins-${radare2_testbins_COMMIT}.tar.gz )
"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE="ssl test"

RDEPEND="
	app-arch/lz4
	>=dev-libs/capstone-5.0_rc4:=
	dev-libs/libzip:=
	dev-libs/xxhash
	sys-apps/file
	sys-libs/zlib
	ssl? ( dev-libs/openssl:0= )
"
DEPEND="
	${RDEPEND}
	dev-util/gperf
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-5.8.4-test.patch"
)

src_prepare() {
	default

	# Unpack subprojects
	cd subprojects

	mv "${WORKDIR}/capstone-${capstone_v5_COMMIT}"/ ./capstone-v5 || die
	cp -rf ./packagefiles/capstone-v5/* ./capstone-v5/
	patch -d capstone-v5 -p1 < ./capstone-v5/capstone-patches/fix-x86-16.patch

	mv "${WORKDIR}/sdb-${sdb_COMMIT}"/ ./sdb || die

	mv "${WORKDIR}/quickjs-${qjs_COMMIT}"/ ./qjs || die
	cp -rf ./packagefiles/qjs/* ./qjs/

	mv "${WORKDIR}/binaryninja-api-${binaryninja_COMMIT}"/ ./binaryninja || die
	cp -rf ./packagefiles/binaryninja/* ./binaryninja/

	cd ${S}
	if use test; then
		cp -r "${WORKDIR}/radare2-testbins-${radare2_testbins_COMMIT}" "${S}/test/bins" || die
		cp -r "${WORKDIR}/radare2-testbins-${radare2_testbins_COMMIT}" "${S}" || die
	fi

	# Fix hardcoded docdir for fortunes
	sed -i -e "/^#define R2_FORTUNES/s/radare2/$PF/" \
		libr/include/r_userconf.h.acr || die
}

src_configure() {
	# Ideally these should be set by ./configure
	tc-export CC AR LD OBJCOPY RANLIB
	export HOST_CC=${CC}

	econf \
		--with-syscapstone \
		--with-syslz4 \
		--with-sysmagic \
		--with-sysxxhash \
		--with-syszip \
		$(use_with ssl)
}

src_test() {
	ln -fs "${S}/binr/radare2/radare2" "${S}/binr/radare2/r2" || die
	LDFLAGS=""
	for i in "${S}"/libr/*; do
		if [[ -d ${i} ]]; then
			LDFLAGS+="-Wl,-rpath=${i} -L${i} "
			LD_LIBRARY_PATH+=":${i}"
		fi
	done
	export LDFLAGS LD_LIBRARY_PATH
	export PKG_CONFIG_PATH="${S}/pkgcfg"
	PATH="${S}/binr/radare2:${PATH}" emake -C test -k unit-tests || die
}

src_install() {
	default

	insinto /usr/share/zsh/site-functions
	doins doc/zsh/_*

	newbashcomp doc/bash_autocompletion.sh "${PN}"
	bashcomp_alias "${PN}" rafind2 r2 rabin2 rasm2 radiff2

	# a workaround for unstable $(INSTALL) call, bug #574866
	local d
	for d in doc/*; do
		if [[ -d ${d} ]]; then
			rm -rfv "${d}" || die "failed to delete '${d}'"
		fi
	done

	# These are not really docs. radare assumes
	# uncompressed files: bug #761250
	docompress -x /usr/share/doc/${PF}/fortunes.{creepy,fun,nsfw,tips}

	# Create plugins directory although it's currently unsupported by radare2
	keepdir "/usr/$(get_libdir)/radare2/${PV}" || die
}
