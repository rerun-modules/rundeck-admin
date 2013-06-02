#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p schedule-takeover [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "schedule-takeover"


# Global settings.
# ----------------
CREDS="--user admin --password admin --url http://localhost:4440"

rerun rundeck-admin:project-create $CREDS --project test-$$

# Tests.
# ------

it_takes_over_bogus() {
    job_ids=( $(rerun rundeck-admin:schedule-takeover $CREDS --uuid XXXXXXXX) )
    test -z "$job_ids"
}


