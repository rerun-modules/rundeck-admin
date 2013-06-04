The *rundeck-admin* commands help you manage your rundecks.

See the [commands](https://github.com/ahonor/rundeck-admin/tree/master/commands) for
the module contents.

**Requirements**

* [rerun](http://github.com/rerun/rerun)
* [curl](http://curl.haxx.se/docs/manpage.html)
* [xmlstarlet](http://xmlstar.sourceforge.net/)
* [expect](http://en.wikipedia.org/wiki/Expect) (for ssh-copy-id)

**Download**

[![Build Status](https://travis-ci.org/ahonor/rundeck-admin.png?branch=master)](https://travis-ci.org/ahonor/rundeck-admin)

[Download a shell archive from bintray](http://dl.bintray.com/ahonor/rerun-modules). 

Or install it via yum:

    curl -s -f -L -o /etc/yum.repos.d/rerun.repo "https://bintray.com/ahonor/rerun-rpm/rpm"
    yum -y install rerun rerun-rundeck-admin

**Using**

To list the commands in the module:

    rerun rundeck-admin

If you downloaded the shell archive it is similar, except rerun.bin is the
executable that contains the module:

    rerun.bin rundeck-admin

The rundeck-admin commands require three options for accessing rundeck:
--user, --password, --url. 
It can be repetitive to always specify these options each time you run a command.
Rerun can help populate them via an answer file. For example,

    cat >rundeck-admin.answers<<EOF
    USER=admin
    PASSWORD=admin
    URL=http://localhost:4440
    EOF

Here's an example showing `project-list` using input from the answers file:

    rerun --answers rundeck-admin.answers rundeck-admin:project-list

