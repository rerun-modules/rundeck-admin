#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p project-import [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "project-import"

# Global settings.
# ----------------
CREDS="--user admin --password admin --url http://localhost:4440"

rerun rundeck-admin:project-create $CREDS --project test-$$

# Tests.
# ------

it_imports_a_project() {

    ARCHIVE=$(mktemp "/tmp/project.archive.XXXX")
    # Create a project archive
    rerun rundeck-admin:project-export $CREDS --project test-$$ --archive $ARCHIVE
    test -f $ARCHIVE

    # Create a new project: 
    rerun rundeck-admin:project-create $CREDS --project test-$$-new

    # Import the archive to the same project
    rerun rundeck-admin:project-import $CREDS --project test-$$-new --archive $ARCHIVE

}

