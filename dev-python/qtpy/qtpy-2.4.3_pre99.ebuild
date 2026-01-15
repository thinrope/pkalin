# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_PN=QtPy
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 virtualx pypi

DESCRIPTION="Abstraction layer on top of PyQt and PySide with additional custom QWidgets"
HOMEPAGE="
	https://github.com/spyder-ide/qtpy/
	https://pypi.org/project/QtPy/
"
# HARDCODE 2.4.3
SRC_URI="$(pypi_sdist_url "QtPy" "2.4.3")"
S="${WORKDIR}/${PN}-2.4.3"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~loong ~ppc64 ~riscv x86"

_IUSE_QT_MODULES="
	bluetooth dbus designer +gui help multimedia +network nfc opengl pdfium
	positioning printsupport qml quick quick3d remoteobjects scxml sensors
	serialport spatialaudio speech +sql svg testlib vulkan webchannel
	webengine websockets +widgets +xml
"
IUSE="+pyqt6 pyside6 ${_IUSE_QT_MODULES}"
unset _IUSE_QT_MODULES

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	pyqt6? (
		dev-python/pyqt6[${PYTHON_USEDEP}]
		dev-python/pyqt6[bluetooth?,dbus?,designer?,gui?,help?,multimedia?]
		dev-python/pyqt6[network?,nfc?,opengl?,pdfium?,positioning?]
		dev-python/pyqt6[printsupport?,qml?,quick?,quick3d?,remoteobjects?]
		dev-python/pyqt6[scxml(-)?,sensors?,serialport?,spatialaudio?,speech?]
		dev-python/pyqt6[sql?,svg?,testlib?,vulkan?,webchannel?,websockets?]
		dev-python/pyqt6[widgets?,xml?]
		webengine? ( dev-python/pyqt6-webengine[${PYTHON_USEDEP},widgets?,quick?] )

	)
	pyside6? (
		dev-python/pyside:6[${PYTHON_USEDEP},core(+)]
		dev-python/pyside:6[bluetooth?,dbus?,designer?,gui?,help?,multimedia?]
		dev-python/pyside:6[network?,nfc?,opengl?,pdfium?,positioning?]
		dev-python/pyside:6[printsupport?,qml?,quick?,quick3d?,remoteobjects(-)?]
		dev-python/pyside:6[scxml?,sensors?,serialport?,spatialaudio?,speech?]
		dev-python/pyside:6[sql?,svg?,testlib?,vulkan(+)?,webchannel?,webengine?]
		dev-python/pyside:6[websockets?,widgets?,xml?]
	)
"

# The QtPy testsuite skips tests for bindings that are not installed, so here we
# ensure that everything is available and all tests are run. Note that not
# all flags are available in PyQt5/PySide2, so some tests are still skipped.
BDEPEND="
	test? (
		dev-python/pytest-qt[${PYTHON_USEDEP}]
		pyqt6? (
			dev-python/pyqt6[${PYTHON_USEDEP}]
			dev-python/pyqt6[bluetooth,dbus,designer,gui,help,multimedia]
			dev-python/pyqt6[network,nfc,opengl,pdfium,positioning,printsupport]
			dev-python/pyqt6[qml,quick,quick3d,scxml(-),sensors,serialport]
			dev-python/pyqt6[spatialaudio,speech,sql,svg,testlib,webchannel]
			dev-python/pyqt6[vulkan(-),websockets,widgets,xml]
			dev-python/pyqt6-webengine[${PYTHON_USEDEP},widgets,quick]
			dev-qt/qtbase:6[sqlite]
		)
		pyside6? (
			dev-python/pyside:6[${PYTHON_USEDEP},core(+)]
			dev-python/pyside:6[3d,bluetooth,charts,concurrent,dbus,designer,gui]
			dev-python/pyside:6[help,location,multimedia,network,network-auth]
			dev-python/pyside:6[nfc,opengl,pdfium,positioning,printsupport,qml]
			dev-python/pyside:6[quick,quick3d,scxml,sensors,serialport]
			dev-python/pyside:6[spatialaudio,speech,sql,svg,testlib,vulkan(+)]
			dev-python/pyside:6[webchannel,webengine,websockets,widgets,xml]
			dev-qt/qtbase:6[sqlite]
		)
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	# Disable Qt for Python implementations that are not selected

	# Do NOT yet  disable PyQt5

	# Always disable PySide2
	sed \
		-e "s/from PySide2 import/raise ImportError #/" \
		-e "s/from PySide2.QtCore import/raise ImportError #/" \
		-e '/if "PySide2" in sys.modules:/,/"pyside2"/c\' \
		-i qtpy/__init__.py || die

	sed \
		-e 's/elif "PyQt6" in sys.modules:/if "PyQt6" in sys.modules:/g' \
		-i qtpy/__init__.py || die

	if ! use pyqt6; then
		sed \
			-e '/from PyQt6.QtCore import/,/)/c\ \ \ \ \ \ \ \ raise ImportError #/' \
			-e '/if "PyQt6" in sys.modules:/,/"pyqt6"/c\' \
			-i qtpy/__init__.py || die

		sed \
			-e 's/elif "PySide6" in sys.modules:/if "PySide6" in sys.modules:/g' \
			-i qtpy/__init__.py || die
	fi
	if ! use pyside6; then
		sed \
			-e "s/from PySide6 import/raise ImportError #/" \
			-e "s/from PySide6.QtCore import/raise ImportError #/" \
			-e '/if "PySide6" in sys.modules:/,/"pyside6"/c\' \
			-i qtpy/__init__.py || die
	fi
}

python_test() {
	local -x QT_API
	local -a EPYTEST_DESELECT
	local other

	# Test for each enabled Qt4Python target.
	# Deselect the other targets, their test fails if we specify QT_API
	# or if we have disabled their corresponding inherit in __init__.py above
	for QT_API in PyQt6 PySide6; do
		if use "${QT_API,,}"; then
			EPYTEST_DESELECT=()
			for other in PyQt{5,6} PySide{2,6}; do
				if [[ ${QT_API} != ${other} ]]; then
					EPYTEST_DESELECT+=(
						"qtpy/tests/test_main.py::test_qt_api_environ[${other}]"
					)
				fi
			done

			einfo "Testing with ${EPYTHON} and QT_API=${QT_API}"
			nonfatal epytest -o addopts= ||
				die -n "Tests failed with ${EPYTHON} and QT_API=${QT_API}" ||
				return 1
		fi
	done
}

src_test() {
	virtx distutils-r1_src_test
}

pkg_postinst() {
	ewarn "This is a quick hack ebuild from an overlay, don't complain!"
	ewarn "Use QT_API=PYQT5 <command> for example."
}
