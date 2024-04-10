# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Plaso (log2timeline) is a framework to create super timelines."
HOMEPAGE="https://github.com/log2timeline/plaso"
SRC_URI="https://github.com/log2timeline/plaso/releases/download/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

# Upstream specifies certifi >= 2016.9.26 as a requirement. Gentoo has certifi-system-store packaged as
# dev-python/certifi. This is a replacement package with a) a different versioning scheme and b) a warning
# against production use. We'll try using the existing package for now, knowing that we might have to
# package the original certifi if anything goes wrong.

# FIXME: automate this better, from setup.cfg
# (echo 'RDEPEND="'; for P in $(cat setup.cfg |perl -ne 'chomp; @F=split/ \>\= /; $F[0] =~ s/-*python3-*//; $C{$F[0]}=$F[1]; END{print map {"$_-$C{$_}\n"} keys %C}'); do echo -ne "\t>="; PN=$(echo $P|cut -d- -f1); eix -I -e --format '<installedversions:NAMEVERSION>' --pure-packages $PN |perl -pe 's/\n/ /g'; echo -e "\t\t<--$P"; done | sort) >deps

RDEPEND="
	>=app-forensics/acstore-20240407
	>=dev-python/artifacts-20220219[${PYTHON_USEDEP}]
	>=dev-python/bencode_py-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-3021.3.16-r3[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-1.5[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/dfdatetime-20240330[${PYTHON_USEDEP}]
	>=app-forensics/dfvfs-20240115
	>=app-forensics/dfwinreg-20240229
	>=dev-python/dtfabric-20230518[${PYTHON_USEDEP}]
	>=dev-python/flor-1.1.3[${PYTHON_USEDEP}]
	>=dev-python/lz4-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/opensearch_py-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/pefile-2023.2.7[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.4.3[${PYTHON_USEDEP}]
	>=app-forensics/libbde-20220121[python]
	>=dev-libs/libcaes-20221127[python]
	>=dev-libs/libcreg-20200725[python]
	>=app-forensics/libesedb-20220806[python]
	>=app-forensics/libevt-20191104[python]
	>=app-forensics/libevtx-20220724[python]
	>=app-forensics/libewf-20131210
	>=dev-libs/libfcrypto-20240114
	>=app-forensics/libfsapfs-20220709[python]
	>=app-forensics/libfsext-20220829[python]
	>=app-forensics/libfsfat-20220925[python]
	>=app-forensics/libfshfs-20220831[python]
	>=app-forensics/libfsntfs-20211229[python]
	>=app-forensics/libfsxfs-20220829[python]
	>=app-forensics/libfvde-20220121[python]
	>=dev-libs/libfwnt-20210717[python]
	>=dev-libs/libfwsi-20240225[python]
	>=app-forensics/liblnk-20230716[python]
	>=app-forensics/libluksde-20220121[python]
	>=app-forensics/libmodi-20210405[python]
	>=app-forensics/libmsiecf-20150314[python]
	>=app-forensics/libolecf-20151223[python]
	>=dev-python/pyparsing-3.0.0[${PYTHON_USEDEP}]
	>=app-forensics/libphdi-20220228[python]
	>=app-forensics/libqcow-20201213[python]
	>=app-forensics/libregf-20201002[python]
	>=app-forensics/libscca-20190605[python]
	>=dev-libs/libsigscan-20230109[python]
	>=app-forensics/libsmraw-20140612[python]
	>=app-forensics/pytsk-20210419[${PYTHON_USEDEP}]
	>=dev-python/pytz-2023.3-r1[${PYTHON_USEDEP}]
	>=dev-libs/libvhdi-20201014[python]
	>=dev-libs/libvmdk-20140421[python]
	>=app-forensics/libvsapm-20240226[python]
	>=app-forensics/libvsgpt-20211115[python]
	>=app-forensics/libvshadow-20160109[python]
	>=app-forensics/libvslvm-20160109[python]
	>=dev-python/redis-3.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.21.1[${PYTHON_USEDEP}]
	>=dev-python/pyxattr-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/xlsxwriter-0.9.3[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/yara-python-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/pyzmq-2.1.11[${PYTHON_USEDEP}]
	>=dev-python/zstd-1.3.0.2[${PYTHON_USEDEP}]
	>=dev-libs/libsmdev-20140529[python]
	${PYTHON_DEPS}
	test? (
		>=dev-python/fakeredis-1.4.1[${PYTHON_USEDEP}]
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pbr-4.2.0[${PYTHON_USEDEP}]
		>=dev-python/sortedcontainers-2.1.0[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests setup.py

src_prepare() {
	sed -i -e "s#share/doc/${PN}#share/doc/${P}#;" setup.py || die
	distutils-r1_src_prepare
}
