#!/usr/bin/env bash

# Fail fast on errors and unset variables.
set -e
set -u


# The module we're building.
MODULE=rundeck-archive
# The bintray info.
BINTRAY_USER=ahonor BINTRAY_ORG=ahonor BINTRAY_REPO=rerun-modules

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

[ ! -f ./rerun.bin ] && {
    echo >&2 "ERROR: archive was not created."; exit 1
}

# Test the archive by making it do a command list.
./rerun.bin $MODULE

# Upload and publish to bintray
echo "Uploading the build to bintray: /${BINTRAY_ORG}/${BINTRAY_REPO}/${MODULE}/${VERSION}..."
$RERUN bintray:package-upload \
    --user ${BINTRAY_USER} --apikey ${BINTRAY_APIKEY} \
    --org ${BINTRAY_ORG}   --repo ${BINTRAY_REPO} \
    --package $MODULE      --version $VERSION \
    --file rerun.bin

echo "Done."