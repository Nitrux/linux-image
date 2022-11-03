#! /bin/sh

apt-get --yes update
apt-get --yes install wget equivs curl git

git config --global --add safe.directory /home/travis/build/Nitrux/linux-image

deps=$(sed -e '/^#.*$/d; /^$/d; /^\s*$/d' package/dependencies | paste -sd ,)
git_commit=$(git rev-parse --short HEAD)

> configuration printf "%s\n" \
	"Section: misc" \
	"Priority: optional" \
	"Homepage: https://nxos.org" \
	"Package: linux-image-xanmod-lts" \
	"Version: 0.0.8-$git_commit" \
	"Maintainer: Uri Herrera <uri_herrera@nxos.org>" \
	"Depends: $deps" \
	"Conflicts: " \
	"Architecture: amd64" \
	"Description: Meta package to install xanmod LTS Linux kernel."

equivs-build configuration
