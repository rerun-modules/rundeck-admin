#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p resource-add [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "resource-add"

# Global settings.
# ----------------
CREDS="--user admin --password admin --url http://localhost:4440"
rerun rundeck-admin:project-create $CREDS --project test-$$

# Tests.
# ------

it_creates_a_resource() {
    rerun rundeck-admin:resource-add $CREDS --project test-$$ --model "-name gilligan -description 'silly sailor'"
}

it_updates_a_resource() {
    CREDS="--user admin --password admin --url http://localhost:4440"
    rerun rundeck-admin:resource-add $CREDS --project test-$$ --model "-name gilligan -description 'silly sailor' -osFamily comedian -blar blar"
}

# ------------------------------

