Use **ssh-copy-id** to copy an SSH key to another server.

The `--user` and `--password` options specify the system login account
to add the SSH key to. Behind the scenes an expect script is used
to login to the remote host to copy the key.

This command is a simple wrapper around [ssh-copy-id](http://linux.die.net/man/1/ssh-copy-id).

Examples
--------

Copy the specified key file to the host, 'rundeck2':

    rerun rundeck-admin: ssh-copy-id --user rundeck --password rundeck123 \
      --keyfile $RDECK_BASE/etc/ssh/id_rsa.pub --hostname rundeck2

