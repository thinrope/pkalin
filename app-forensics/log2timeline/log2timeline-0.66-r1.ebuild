# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Create forensic supertimelines in Perl"
HOMEPAGE="https://github.com/thinrope/log2timeline"
SRC_URI="https://github.com/thinrope/log2timeline/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
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
