#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p project-create [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "project-create"


it_creates_a_projects() {
    rerun rundeck-admin:project-create --project test-$$ \
        --url http://localhost:4440 \
        --user admin --password admin


    projects=($(rerun rundeck-admin:project-list --url http://localhost:4440 \
        --user admin --password admin))
    echo "${projects[*]}" | grep test-$$
}


