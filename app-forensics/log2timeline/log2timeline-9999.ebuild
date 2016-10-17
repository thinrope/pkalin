# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit perl-module git-r3

DESCRIPTION="Create forensic supertimelines in Perl"
HOMEPAGE="https://github.com/thinrope/log2timeline"
SRC_URI=""
EGIT_REPO_URI="https://github.com/thinrope/log2timeline"
EGIT_COMMIT="HEAD"

LICENSE="GPL3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/exiftool
	>=dev-perl/Archive-Zip-1.18
	dev-perl/Carp-Assert
	dev-perl/DBI
	dev-perl/DBD-SQLite
	dev-perl/Data-Hexify
	>=dev-perl/DateTime-0.41
	dev-perl/DateTime-Format-Strptime
	dev-perl/DateTime-TimeZone
	>=dev-perl/Digest-CRC-0.14
	dev-perl/HTML-Scrubber
	dev-perl/Net-Pcap
	dev-perl/NetPacket
	dev-perl/Params-Validate
	dev-perl/XML-LibXML
	dev-perl/File-Mork
	dev-perl/JSON-XS
	dev-perl/Mac-PropertyList
	dev-perl/Parse-Win32Registry"

RDEPEND="${DEPEND}"
