#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p project-list [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "project-list"


it_lists_projects() {
    projects=($(rerun rundeck-admin:project-list --url http://localhost:4440 \
        --user admin --password admin))
    test -n "$projects"
}


