#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p apitoken-list [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "apitoken-list"

before() {
    apitoken_remove_all admin admin http://localhost:4440
}

# ------------------------------

it_prints_blank_when_no_tokens() {

    toks=($(rerun rundeck-admin:apitoken-list --user admin --password admin --url http://localhost:4440))
    test -z "$toks"
}

it_lists_multiple_tokens() {

    API_KEY1=$(rerun rundeck-admin:apitoken-create --user admin --password admin --url http://localhost:4440)
    API_KEY2=$(rerun rundeck-admin:apitoken-create --user admin --password admin --url http://localhost:4440)

    toks=( $(rerun rundeck-admin:apitoken-list --user admin --password admin --url http://localhost:4440) )
    test "${#toks[*]}" -eq 2

    echo ${toks[*]} | grep $API_KEY1
    echo ${toks[*]} | grep $API_KEY2
}




