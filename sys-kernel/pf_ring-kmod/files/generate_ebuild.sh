#!/bin/bash

MY_PV="9.2.0"

GIT_UPSTREAM="https://github.com/ntop/PF_RING.git"
GIT_BRANCH="origin/${MY_PV}-stable"
GIT_RELEASE="tags/${MY_PV}"

TMP_DIR=$(mktemp -d)
trap '{ rm -rf -- "${TMP_DIR}"; }' EXIT

cd ${TMP_DIR}

git clone ${GIT_UPSTREAM} ${TMP_DIR}/

clear
echo
date +"# Patches updated for ${MY_PV}_p%Y%m%d" --date=$(git log -1 --format="@%at" ${GIT_BRANCH})
git format-patch --output-directory /var/db/repos/pkalin/sys-kernel/pf_ring-kmod/files/ --binary ${GIT_RELEASE}..${GIT_BRANCH} \
	|perl -pe '
	BEGIN {
		print "src_prepare() {\n";
		print "\tlocal GIT_PATCHES=(\n";
	};
       	s#/var/db/repos/pkalin/sys-kernel/pf_ring-kmod/files/#\t\t"\${FILESDIR}/#g;\
       	s#$#"#;
	END {
		print "\t)\n";
		print "\tcd \"\${WORKDIR}/\${MY_P}\"\n";
		print "\tfor GIT_PATCH in \"\${GIT_PATCHES[\@]}\"\n";
		print "\t\do\n";
		print "\t\teinfo \"Applying git patch: \${GIT_PATCH} ...\"\n";
		print "\t\tgit apply \"\${GIT_PATCH}\"\n";
		print "\tdone\n";
		print "\t\default_src_prepare\n";
		print "\}\n";
		print "\n";
	}'
