# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit multilib-build

DESCRIPTION="Virtual for libusb"
SLOT="1"
KEYWORDS="~amd64"
IUSE="static-libs udev"

# We force a recent libusb so that downstream consumers of virtual/libusb
# can depend on us directly (and not have to force >=libusb-1.0.19).
RDEPEND="
	>=dev-libs/libusb-1.0.19:1[udev(+)?,${MULTILIB_USEDEP},static-libs(+)?]
"
