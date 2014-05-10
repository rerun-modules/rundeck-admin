#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p token-remove [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "token-remove"


it_removes_a_token() {

    API_KEY1=$(rerun rundeck-admin:token-create --user admin --password admin --url http://localhost:4440)
    rerun rundeck-admin:token-remove --user admin --password admin --url http://localhost:4440 --token $API_KEY1
    toks=( $(rerun rundeck-admin:token-list --user admin --password admin --url http://localhost:4440) )
    echo ${toks[*]} | grep -v $API_KEY1

}
