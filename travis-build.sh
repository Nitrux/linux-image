#! /bin/sh

apt-get --yes update
apt-get --yes install wget equivs curl git

deps=$(sed -e '/^#.*$/d; /^$/d; /^\s*$/d' package/dependencies | paste -sd ,)
git_commit=$(git rev-parse --short HEAD)

> configuration printf "%s\n" \
	"Section: misc" \
	"Priority: optional" \
	"Homepage: https://nxos.org" \
	"Package: linux-image-mainline-vfio" \
	"Version: 0.0.2-$git_commit" \
	"Maintainer: Uri Herrera <uri_herrera@nxos.org>" \
	"Depends: $deps" \
	"Conflicts: linux-image-mainline-current, linux-image-mainline-lts" \
	"Architecture: amd64" \
	"Description: Meta package to install mainline Linux kernel (with VFIO as external module support)."

equivs-build configuration
