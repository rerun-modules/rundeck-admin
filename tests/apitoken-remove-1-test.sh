#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p apitoken-remove [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "apitoken-remove"


it_removes_a_token() {

    API_KEY1=$(rerun rundeck-admin:apitoken-create --user admin --password admin --url http://localhost:4440)
    rerun rundeck-admin:apitoken-remove --user admin --password admin --url http://localhost:4440 --token $API_KEY1
    toks=( $(rerun rundeck-admin:apitoken-list --user admin --password admin --url http://localhost:4440) )
    echo ${toks[*]} | grep -v $API_KEY1

}