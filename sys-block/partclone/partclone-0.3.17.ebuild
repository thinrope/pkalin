# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils

DESCRIPTION="Partition cloning tool"
HOMEPAGE="http://partclone.org/"
SRC_URI="mirror://sourceforge/${PN}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="btrfs hfs fat exfat minix ntfs vmfs xfs"

# TO_ADD: reiserfs, reiser4, jfs, apfs, ufs, f2fs, nilfs2
#	reiserfs? ( sys-fs/progsreiserfs )
#	reiser4? ( sys-fs/reiser4progs )
#	f2fs? ( sys-fs/f2fs-tools )
#	jfs? ( sys-fs/jfsutils )
#	nilfs? ( sys-fs/nilfs-utils )
#	apfs? FIXME

RDEPEND="sys-fs/e2fsprogs
	btrfs? ( sys-fs/btrfs-progs )
	fat? ( sys-fs/dosfstools )
	ntfs? ( sys-fs/ntfs3g )
	hfs? ( sys-fs/hfsutils )
	xfs? ( sys-fs/xfsprogs )"
DEPEND=""

src_prepare(){
	eautoreconf
	eapply_user
}

src_configure(){
	ECONF_SOURCE="${S}" econf \
	--enable-extfs --enable-ncursesw --enable-fs-test \
	$(use_enable xfs) \
	$(use_enable hfs hfsp) \
	$(use_enable fat) \
	$(use_enable exfat) \
	$(use_enable ntfs) \
	$(use_enable minix) \
	$(use_enable btrfs) \
	$(use_enable vmfs)
}
