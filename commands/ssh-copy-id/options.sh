# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Thu May 23 09:27:59 PDT 2013
#
#/ usage: rundeck-admin:ssh-copy-id  --user <>  --password <> [ --keypath <>]  --hostname <> 

# _rerun_options_parse_ - Parse the command arguments and set option variables.
#
#     rerun_options_parse "$@"
#
# Arguments:
#
# * the command options and their arguments
#
# Notes:
# 
# * Sets shell variables for any parsed options.
# * The "-?" help argument prints command usage and will exit 2.
# * Return 0 for successful option parse.
#
rerun_options_parse() {

    while [ "$#" -gt 0 ]; do
        OPT="$1"
        case "$OPT" in
            --user) rerun_option_check $# $1; USER=$2 ; shift ;;
            --password) rerun_option_check $# $1; PASSWORD=$2 ; shift ;;
            --keypath) rerun_option_check $# $1; KEYPATH=$2 ; shift ;;
            --hostname) rerun_option_check $# $1; HOSTNAME=$2 ; shift ;;
            # help option
            -?)
                rerun_option_usage
                exit 2
                ;;
            # end of options, just arguments left
            *)
              break
        esac
        shift
    done

    # Set defaultable options.

    # Check required options are set
    [ -z "$USER" ] && { echo >&2 "missing required option: --user" ; return 2 ; }
    [ -z "$PASSWORD" ] && { echo >&2 "missing required option: --password" ; return 2 ; }
    [ -z "$HOSTNAME" ] && { echo >&2 "missing required option: --hostname" ; return 2 ; }
    # If option variables are declared exportable, export them.

    #
    return 0
}


# Initialize the options variables to null.
USER=
PASSWORD=
KEYPATH=
HOSTNAME=


