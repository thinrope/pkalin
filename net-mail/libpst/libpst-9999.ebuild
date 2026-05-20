# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit autotools python-single-r1 git-r3

DESCRIPTION="Tools and library for reading Outlook files (.pst format)"
HOMEPAGE="https://www.five-ten-sg.com/libpst/ https://github.com/pst-format/libpst"
EGIT_REPO_URI="https://github.com/pst-format/${PN}"
EGIT_COMMIT="HEAD"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug dii doc python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	gnome-extra/libgsf:=
	virtual/zlib
	dii? ( media-gfx/imagemagick:=[png] )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep 'dev-libs/boost:0=[python,${PYTHON_USEDEP}]')
	)"
DEPEND="${RDEPEND}
	virtual/libiconv
	virtual/pkgconfig
	dii? ( media-libs/gd[png] )"
BDEPEND="
	app-text/xmlto
	app-text/doxygen
"
pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
	# conditionally install the extra documentation
	if ! use doc; then
		sed -i -e "/SUBDIRS/s: html::" Makefile.am || die
	else
		sed -i -e "s#@PACKAGE@-@VERSION@#${PF}#g" html/Makefile.am || die
	fi

	# don't install duplicate docs
	sed -i -e "/^html_DATA =/d" Makefile.am || die

	eapply_user

	eautoreconf
}

src_configure() {
	PYTHON_BIN=${EPYTHON} \
	econf \
		--enable-libpst-shared \
		--disable-nls \
		$(use_enable debug pst-debug) \
		$(use_enable dii) \
		$(use_enable python) \
		$(use_enable static-libs static) \
		$(use_with python boost-python "boost_${EPYTHON/./}")
}

src_compile() {
	emake -C xml
	default
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
