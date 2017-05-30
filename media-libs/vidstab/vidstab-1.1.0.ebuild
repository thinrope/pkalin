# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Video stabilization library"
HOMEPAGE="http://public.hronopik.de/vid.stab/"
EGIT_REPO_URI="https://github.com/georgmartius/vid.stab.git"
EGIT_TAG="v.${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=media-video/ffmpeg-3.2.4-r1
	dev-util/cmake"
RDEPEND="media-video/ffmpeg"
