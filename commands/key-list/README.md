Use **key-list** to list the keys stored in rundeck

The `--keypath <>` option specifies the path to store the key content.

The command output is formatted to show the keypath and type of resource.


Examples
--------

Assuming a key file, solaris.pem, is stored in the path: /alexh/keys/solaris.pem:

    rerun rundeck-admin:key-list --keypath /alexh/keys

The result:

    #keypath,type
    /alexh/keys,directory
    /alexh/keys/solaris.pem,file



