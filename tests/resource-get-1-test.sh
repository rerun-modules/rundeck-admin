#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p resource-get [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "resource-get"

# Global settings.
# ----------------
CREDS="--user admin --password admin --url http://localhost:4440"
rerun rundeck-admin:project-create $CREDS --project test-$$

# Tests.
# ------

it_fails_for_unpported_format() {
    if ! rerun rundeck-admin:resource-get $CREDS --project test-$$ --resource skipper --format B0GUS --file skipper.xml
    then
        :;#yay
    else
        exit 1
    fi
}

it_gets_a_resource() {
    
    name="skipper"
    description="a bumbling captain"
    resultfile=$(mktemp "/tmp/resource.xml.XXXX")

    # Add a resource.
    rerun rundeck-admin:resource-add $CREDS --project test-$$  --data "-name ${name} -description '${description}'"

    # Get the resource.
    
    # Sepcify an output file.
    rerun rundeck-admin:resource-get $CREDS --project test-$$ --resource ${name} --format xml --file ${resultfile}
    xmlstarlet val ${resultfile}

    test "$name" = "$(xmlstarlet sel -t -m "/project/node" -v @name ${resultfile})"
    test "$description" = "$(xmlstarlet sel -t -m "/project/node" -v @description ${resultfile})"

    # Redirect standard output to a file.
    rerun rundeck-admin:resource-get $CREDS --project test-$$ --resource ${name} --format xml > $resultfile
    xmlstarlet val ${resultfile}

}
# ------------------------------

