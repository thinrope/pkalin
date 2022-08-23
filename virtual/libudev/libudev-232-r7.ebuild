# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-build

DESCRIPTION="Virtual for libudev providers"

SLOT="0/1"
KEYWORDS="~amd64"
IUSE="static-libs systemd"

RDEPEND="
	!systemd? ( || (
		sys-apps/systemd-utils[udev,${MULTILIB_USEDEP},static-libs(-)?]
		sys-fs/udev[${MULTILIB_USEDEP},static-libs(-)?]
		>=sys-fs/eudev-3.2.9:0/0[${MULTILIB_USEDEP},static-libs(-)?]
	) )
	systemd? ( >=sys-apps/systemd-232:0/2[${MULTILIB_USEDEP},static-libs(-)?] )
"
