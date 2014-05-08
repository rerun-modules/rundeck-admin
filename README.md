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

