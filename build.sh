#!/usr/bin/env bash
set -o errexit -o pipefail

# Set some default variables
WORKINGDIR="$(dirname $(readlink -f ${0}))"
RELEASEDIR="${WORKINGDIR}/releases"
SOURCEDIR="/tmp/ubergallery-source"
GITDIR="${SOURCEDIR}/.git"

# Remove source dir if it already exists
if [[ -d "${SOURCEDIR}" ]]; then
    rm -rfv ${SOURCEDIR}
fi

# Get updated source from Github
git clone --recursive -q git://github.com/UberGallery/UberGallery.git ${SOURCEDIR}

# Set version info variables
VERSION=$(cat "${SOURCEDIR}/resources/UberGallery.php" | grep "const VERSION" | awk -F \' '{ print $(NF-1) }')
RELEASENAME="UberGallery-v${VERSION}"
FINALDIR="/tmp/${RELEASENAME}"

# Remove all git files
find ${SOURCEDIR} -name ".git*" -exec rm -rf {} \;

# Remove scripts directory
rm -r ${SOURCEDIR}/scripts

# Rename source directory to release directory
if [[ -d ${FINALDIR} ]]; then
    rm -rf ${FINALDIR}
fi

mv ${SOURCEDIR} ${FINALDIR}

# Create ubergallery-release folder if not present
if [[ ! -d ${RELEASEDIR} ]]; then
    mkdir ${RELEASEDIR}
fi

# Change directories
cd /tmp

# Make the .tar.gz release file
tar -czf ${RELEASEDIR}/${RELEASENAME}.tar.gz ${RELEASENAME} --overwrite

# Make the .zip release file
zip -qr ${RELEASEDIR}/${RELEASENAME}.zip ${RELEASENAME}
