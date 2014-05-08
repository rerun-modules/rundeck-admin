# 
# Test functions for command tests.
#

CURLOPTS="-f -s -S -L -c cookies -b cookies"
CURL="curl $CURLOPTS"
CURLOUT=$(mktemp -t curl.out.XXXXXXXXXX)

apitoken_list() {
    echo 'inside apitoken_list' >>/tmp/blar

    [ $# -ne 3 ] && {
        echo >&2 'usage: apitoken_list user password url'
        exit 2
    }

    USER=${1} PASSWORD=${2} URL=${3}

    loginurl="${URL}/j_security_check"
    $CURL $loginurl > /dev/null
    timeout 30s $CURL -X POST -d j_username=$USER -d j_password=$PASSWORD $loginurl > /dev/null

    profileurl="${URL}/user/profile"
    timeout 30s $CURL -o $CURLOUT -X GET $profileurl

    xmlstarlet fo -R -H $CURLOUT > $CURLOUT.userprofile.html 2>/dev/null

    if ! xmlstarlet sel -N x="http://www.w3.org/1999/xhtml" -t -m "//x:span[@class='apitoken']" -v . -n $CURLOUT.userprofile.html
    then
        :; # no tokens
    fi

}

apitoken_remove_all() {
    [ $# -ne 3 ] && {
        echo >&2 'usage: apitoken_removeall user password url'
        exit 2
    }

    USER=${1} PASSWORD=${2} URL=${3} 
    APIURL=$URL/user/clearApiToken

    tokens=( $(apitoken_list $USER $PASSWORD $URL) )
    for token in ${tokens[*]}
    do
        timeout 30s $CURL -d login=${USER} -d token=${token} -d Yes=yes -X POST $APIURL > /dev/null
    done
}

