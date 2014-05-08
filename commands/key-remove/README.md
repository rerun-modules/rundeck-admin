Use **key-remove** to remove the key data for the specified path.

The `--keypath <>` option specifies the path to stored key content.

> Note, if no file is found at the specified path, no error is raised.

Examples
--------

Remove the public key data stored in the path: /alexh/keys/my.pub:

    rerun rundeck-admin:key-remove --keypath /alexh/keys/my.pub 
