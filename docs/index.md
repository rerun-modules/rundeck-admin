# rundeck-admin

commands to manage your rundecks

## SYNOPSIS

    rerun [ARGS] rundeck-admin: [ jobs-archive | key-content | key-list | key-remove | key-upload | project-configure | project-create | project-export | project-import | project-info | project-list | project-remove | project-replicate | resource-add | resource-get | schedule-takeover | ssh-copy-id | token-create | token-list | token-remove ] [OPTIONS]

## README

The *rundeck-admin* commands help you manage your rundecks.

See the [commands](https://github.com/ahonor/rundeck-admin/tree/master/commands) for
the module contents.

**Requirements**

* [rerun](http://github.com/rerun/rerun)
* [curl](http://curl.haxx.se/docs/manpage.html)
* [xmlstarlet](http://xmlstar.sourceforge.net/)
* [expect](http://en.wikipedia.org/wiki/Expect) (for ssh-copy-id)

**Download**

[![Build Status](https://travis-ci.org/rerun-modules/rundeck-admin.png?branch=master)](https://travis-ci.org/rerun-modules/rundeck-admin)

You can download a build of this module either as a shell archive or an RPM.

* [Download a shell archive from bintray](http://dl.bintray.com/ahonor/rerun-modules/rundeck-admin). This is a self-contained module and does not require a rerun installation. Simply download the rerun.bin file and make it executable.
       
         chmod +x ./rerun.bin

* Or install it via RPM and yum:

         curl -s -f -L -o /etc/yum.repos.d/rerun.repo "https://bintray.com/ahonor/rerun-rpm/rpm" ;# Add bintray yum repo.
         yum -y install rerun rerun-rundeck-admin

**Using**

To list the commands in the module:

    rerun rundeck-admin

If you downloaded the shell archive , command listing is similar except rerun.bin is the
executable that contains the module:

    rerun.bin rundeck-admin

**Options**

The rundeck-admin commands require three common options used to access rundeck:
--user, --password, --url. 

* `--user`: The user login (eg admin). Many commands require this user to be in the "admin" group.
* `--password`: The login password (eg admin).
* `--url`: The rundeck base url (eg, http://localhost:4440)

It can be repetitive to always specify these options each time you run a command
or you may not like passing the credential information on the command line.
You have two options: environment variables or answers file.

To use defaults from environment variables, declare the following

    export RUNDECK_USER=admin
    export RUNDECK_PASSWORD=admin
    export RUNDECK_URL=http://rundeck:4440

Rerun can help populate options and their arguments via an answer file. For example,
here is an answers files that stores the user, password and url values:

    cat >creds<<EOF
    USER=admin
    PASSWORD=admin
    URL=http://rundeck:4440
    EOF

Here's `project-list` using the user,password and url info from the answer file:

    $ rerun --answers creds rundeck-admin:project-list
    examples

## COMMANDS

* [jobs-archive](commands/jobs-archive/index.html): Archive job files suitable for project import.
* [key-content](commands/key-content/index.html): Get the key data content.
* [key-list](commands/key-list/index.html): List the key paths in the store.
* [key-remove](commands/key-remove/index.html): Remove a key from the store.
* [key-upload](commands/key-upload/index.html): Upload key data and store it in the path.
* [project-configure](commands/project-configure/index.html): Configure a project.
* [project-create](commands/project-create/index.html): Create a project.
* [project-export](commands/project-export/index.html): Export a project.
* [project-import](commands/project-import/index.html): Import a project archive.
* [project-info](commands/project-info/index.html): Get info about a project.
* [project-list](commands/project-list/index.html): List the projects.
* [project-remove](commands/project-remove/index.html): Remove a project.
* [project-replicate](commands/project-replicate/index.html): Replicate the project(s) from one rundeck to another.
* [resource-add](commands/resource-add/index.html): Add a resource to a project resource model.
* [resource-get](commands/resource-get/index.html): Get resource info.
* [schedule-takeover](commands/schedule-takeover/index.html): Claim all scheduled jobs from another cluster server.
* [ssh-copy-id](commands/ssh-copy-id/index.html): Copy an SSH key to another server.
* [token-create](commands/token-create/index.html): Create an API token.
* [token-list](commands/token-list/index.html): List the API tokens.
* [token-remove](commands/token-remove/index.html): Remove an api token.

## OPTIONS

* [archive](options/archive/index.html): the archive file.
* [dir](options/dir/index.html): directory path
* [file](options/file/index.html): file to store result.
* [format](options/format/index.html): the file format.
* [hostname](options/hostname/index.html): the server hostname.
* [import-executions](options/import-executions/index.html): Creates new Executions and History reports from the archive.
* [keypath](options/keypath/index.html): path to key file.
* [model](options/model/index.html): the resource model.
* [password](options/password/index.html): the login password.
* [project](options/project/index.html): the project name.
* [resource](options/resource/index.html): the resource name.
* [retain-uuids](options/retain-uuids/index.html): Create Jobs with their defined UUIDs or a new UUID will be generated for each Job created.
* [to-url](options/to-url/index.html): target rundeck instance.
* [token](options/token/index.html): the login token.
* [url](options/url/index.html): rundeck server url.
* [user](options/user/index.html): the login user name.
* [uuid](options/uuid/index.html): the cluster server uuid.

## TESTS

* [jobs-archive-1](tests/jobs-archive-1.html)
* [project-create-1](tests/project-create-1.html)
* [project-export-1](tests/project-export-1.html)
* [project-import-1](tests/project-import-1.html)
* [project-list-1](tests/project-list-1.html)
* [project-remove-1](tests/project-remove-1.html)
* [resource-add-1](tests/resource-add-1.html)
* [resource-get-1](tests/resource-get-1.html)
* [schedule-takeover-1](tests/schedule-takeover-1.html)
* [token-create-1](tests/token-create-1.html)
* [token-list-1](tests/token-list-1.html)
* [token-remove-1](tests/token-remove-1.html)

## LIBRARY

* [functions.sh](lib/functions.html)

## METADATA

* `NAME` = rundeck-admin
* `DESCRIPTION` = "commands to manage your rundecks"
* `SHELL` = "bash"
* `VERSION` = 1.4.0
* `REQUIRES` = 
* `EXTERNALS` = "curl,xmlstarlet,expect,zip"
* `LICENSE` = 

----

*Generated by stubbs:docs Wed May 14 15:58:11 PDT 2014*
