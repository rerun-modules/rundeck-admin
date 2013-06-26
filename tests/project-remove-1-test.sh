#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p project-remove [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "project-remove"

# The Tests
# ----------

it_fails_if_RDECK_BASE_unset() {
	unset RDECK_BASE
   ! rerun rundeck-admin:project-remove --project test-$$ \
        --url http://localhost:4440 \
        --user admin --password admin	
}

it_removes_a_projects() {
    rerun rundeck-admin:project-create --project test-$$ \
        --url http://localhost:4440 \
        --user admin --password admin

   rerun rundeck-admin:project-remove --project test-$$ \
        --url http://localhost:4440 \
        --user admin --password admin


    rerun rundeck-admin:project-list --url http://localhost:4440 --user admin --password admin | 
    if ! grep test-$$
    then : ;# no longer exists.
	else exit 1 ;
	fi

	if [ "$RDECK_BASE" = "/var/lib/rundeck" -a -d "/var/rundeck/projects" ]
	then PROJECTS_DIR=/var/rundeck/projects
	else PROJECTS_DIR=$RDECK_BASE/projects
	fi	
	! test -d $PROJECTS_DIR/test-$$
}


