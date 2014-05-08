# Shell functions for the rundeck module.
#/ usage: source RERUN_MODULE_DIR/lib/functions.sh command
#

# Read rerun's public functions
. $RERUN || {
    echo >&2 "ERROR: Failed sourcing rerun function library: \"$RERUN\""
    return 1
}

# Check usage. Argument should be command name.
[[ $# = 1 ]] || rerun_option_usage

# Source the option parser script.
#
if [[ -r $RERUN_MODULE_DIR/commands/$1/options.sh ]] 
then
    . $RERUN_MODULE_DIR/commands/$1/options.sh || {
        rerun_die "Failed loading options parser."
    }
fi

# - - -
# Your functions declared here.
# - - -

# Where to store the login cookies
COOKIES=$(mktemp "/tmp/cookies.XXXXX")
# Curl opts to accept insecure certs, use a cookie jar, follow redirects, show only errors, fail fast.
CURLOPTS="-k -f -s -S -L -c $COOKIES -b $COOKIES"


#
# _rundeck_curl_ - The curl wrapper function
#
#     rundeck_curl ?curl-args?
#
# Arguments:
#
# * curl-args: Any valid set of curl arguments
#
# Notes: 
rundeck_curl() {
	command curl --user-agent "rerun/$RERUN_VERSION rundeck-admin/${RERUN_MODULE_VERSION:-}" $CURLOPTS "$@"
}

#
# - - -
#

#
# _rundeck_login_ - Login to rundeck
#
#     rundeck_login url user password
#
# Arguments:
#
# * url:      The URL to rundeck.
# * user:     The login user name.
# * password: The password for login.
#
# Notes: 
rundeck_login(){
	[[ $# -ne 3 ]] && {
		rerun_die 2 "usage: rundeck_login: url user password"
	}
	local -r url=$1 user=$2 password=$3

	local http_code errors
	local -r loginurl="${url}/j_security_check"

	# Request the login form.
	if ! http_code=$(rundeck_curl  -w "%{http_code}"  $loginurl 2> /dev/null)
	then
		rerun_die 3 "login failure. http_code: $http_code"
    fi

    # Temporary file to store results.
    local -r curl_out=$(mktemp "/tmp/login.XXXXX")

    # Submit the username and password to the login form.
	if ! http_code=$(rundeck_curl -w "%{http_code}"  -d j_username=$user -d j_password=$password \
		-X POST $loginurl 2>/dev/null -o $curl_out)
	then
		rerun_die 3 "login failure. http_code: $http_code"
	fi

	# Parse the login result page. It might contain an error.
	# Convert the result into well formed xhtml so we can query it.
	if ! errors=$(xmlstarlet fo -R -H $curl_out 2>/dev/null |
		# Query the result page for the error message.
		xmlstarlet sel -N x=http://www.w3.org/1999/xhtml \
			-t -m "//x:div[@class='login']/x:form/x:div[@class='message']/x:span[@class='error']" -v .)
    then
    	:; # no login error message. successfully logged in.
    fi
    rm "${curl_out}"; # clean up.

    # Fail if there was an error.
    [[ -n "${errors:-}" ]] && {
		rerun_die 3 "Login failure. error: $errors"
	}

	return 0
}

rundeck_version() {
	local -r url=$1 

    # Temporary file to store results.
    local -r curl_out=$(mktemp "/tmp/login.out.XXXXX")

	if ! errors=$(rundeck_curl -X GET $url/user/login 2>&1> $curl_out)
	then
		rerun_die 3 "login failure. error: $errors"
	fi

	# Parse the login result page.
	# Convert the result into well formed xhtml so we can query it for version.
	if ! version=$(xmlstarlet fo -R -H $curl_out 2>/dev/null |
		# Query the result page for the error message.
		xmlstarlet sel -N x=http://www.w3.org/1999/xhtml \
			-t -m "//x:div[@id='footer']/x:span[@class='num']" -v . )
    then
    	:; # no version info
    fi
    rm "${curl_out}"; # clean up.
    echo ${version:-}
    return 0
}


