#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p token-create [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "token-create"


# ------------------------------

it_creates_a_token() {

    API_KEY=$(rerun rundeck-admin:token-create --user admin --password admin --url http://localhost:4440)

    test -n "$API_KEY"

    # try the token.

    APIURL="http://localhost:4440/api/1/system/info"
    AUTHHEADER="X-RunDeck-Auth-Token: $API_KEY"
    CURLOPTS="-s -S -L"
    CURL="curl $CURLOPTS"
    CURL_OUT=$(mktemp "/tmp/curl.out.XXXXX")
    timeout 60s $CURL -H "$AUTHHEADER" -o $CURL_OUT $APIURL

    xmlstarlet sel -t -m "/result" -v @success $CURL_OUT

    rm $CURL_OUT
}






