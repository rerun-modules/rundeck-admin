#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p project-export [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "project-export"

# Global settings.
# ----------------
CREDS="--user admin --password admin --url http://localhost:4440"

rerun rundeck-admin:project-create $CREDS --project test-$$

# Tests.
# ------

it_exports_a_project() {

    ARCHIVE=$(mktemp "/tmp/project.archive.XXXX")

    rerun rundeck-admin:project-export $CREDS --project test-$$ --archive $ARCHIVE
    test -f $ARCHIVE
    file $ARCHIVE | grep -i zip

    rm $ARCHIVE
}

it_fails_for_bogus_project() {

    ARCHIVE=$(mktemp "/tmp/project.archive.XXXX")
  	! rerun rundeck-admin:project-export $CREDS --project b0guZ --archive $ARCHIVE


  rm $ARCHIVE
}