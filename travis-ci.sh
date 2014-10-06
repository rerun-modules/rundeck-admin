#!/usr/bin/env bash

# Fail fast on errors and unset variables.
set -eu


# The module we're building.
MODULE=rundeck-admin
# The bintray info.
BINTRAY_USER=ahonor BINTRAY_ORG=rerun 

# Prepare.
# --------
VERSION=$(awk -F= '/VERSION/ {print $2}' metadata)
[ -z "${VERSION:-}" ] && {
    echo >&2 "ERROR: Version info could not be found in metadata file."; exit 1
}


echo "Building version $VERSION..."
# Create a scratch directory and change directory to it.
WORK_DIR=$(mktemp -d "/tmp/build-$MODULE.XXXXXX")

# Bootstrap
# ---------

# Get rerun so we have access to stubbs:archive command.
echo "Getting rerun..."
pushd $WORK_DIR
git clone git://github.com/rerun/rerun.git rerun
# chdir to original directory where module this module source resides.
popd; 

# Setup the rerun execution environment.
export RERUN_MODULES=$WORK_DIR/rerun/modules
export RERUN=$WORK_DIR/rerun/rerun

# Add bintray module into the $RERUN_MODULES directory
echo "Getting bintray module..."
pushd $RERUN_MODULES
git clone git://github.com/rerun-modules/bintray.git bintray
popd

# Build the module.
# -----------------
echo "Packaging the build..."
# Copy the module files into the work directory.
mkdir -p $RERUN_MODULES/$MODULE
echo "copying $MODULE files into working directory..."
tar cf - * | (cd  $WORK_DIR/rerun/modules/$MODULE/ && tar xvf -)

pushd $WORK_DIR
# Build the archive!
$RERUN stubbs:archive --modules $MODULE
BIN=rerun.sh
[ ! -f $BIN ] && {
    echo >&2 "ERROR: $BIN archive was not created."; exit 1
}

# Test the archive by making it do a command list.
./$BIN $MODULE

# Upload and publish to bintray
echo "Uploading $BIN to bintray: /${BINTRAY_ORG}/rerun-modules/${MODULE}/${VERSION}..."
$RERUN bintray:package-upload \
    --user ${BINTRAY_USER} --apikey ${BINTRAY_APIKEY} \
    --org ${BINTRAY_ORG}   --repo rerun-modules \
    --package $MODULE      --version $VERSION \
    --file $BIN

# Build a deb
#-------------
$RERUN stubbs:archive --modules $MODULE --format deb --version ${VERSION} --release ${RELEASE:=1}
DEB=rerun-${MODULE}_${VERSION}-${RELEASE}_all.deb
[ ! -f $DEB ] && {
    echo >&2 "ERROR: $DEB file was not created."
    files=( *.deb )
    echo >&2 "ERROR: ${#files[*]} files matching .deb: ${files[*]}"
    exit 1
}
echo "Uploading debian package $DEB to bintray: /${BINTRAY_ORG}/rerun-deb ..."
$RERUN bintray:package-upload \
    --user ${BINTRAY_USER} --apikey ${BINTRAY_APIKEY} \
    --org ${BINTRAY_ORG}   --repo rerun-deb \
    --package rerun-${MODULE}      --version $VERSION \
    --file $DEB

# Build a rpm
#-------------
$RERUN stubbs:archive --modules $MODULE --format rpm --version ${VERSION} --release ${RELEASE:=1}
RPM=rerun-${MODULE}-${VERSION}-${RELEASE}.noarch.rpm
[ ! -f $RPM ] && {
    echo >&2 "ERROR: $RPM file was not created."
    files=( *.rpm )
    echo >&2 "ERROR: ${#files[*]} files matching .rpm: ${files[*]}"
    exit 1
}
echo "Uploading rpm package $RPM to bintray: /${BINTRAY_ORG}/rerun-rpm ..."
$RERUN bintray:package-upload \
    --user ${BINTRAY_USER} --apikey ${BINTRAY_APIKEY} \
    --org ${BINTRAY_ORG}   --repo rerun-rpm \
    --package rerun-${MODULE}      --version $VERSION \
    --file $RPM





echo "Done."
