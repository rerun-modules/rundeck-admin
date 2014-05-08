Use **key-upload** to upload key data content to the specified path.


The `--file <>` option specifies the file containing the key content you wish to upload.

The `--keypath <>` option specifies the path to store the key content.

The `--format <>` option specifies if the key content is public or private.

Formats:

* public: The content can be retrieved using the **key-content** command.
* private: The content cannon be retreived and instead metadata is returned.

Examples
--------

Store the public key data stored as my.pub in the path: /alexh/keys/my.pub:

    rerun rundeck-admin:key-upload --file my.pub --keypath /alexh/keys/my.pub 

Store the private key data stored in my.pem in the path: /alexh/keys/my.pem:

    rerun rundeck-admin:key-upload --file my.pem --keypath /alexh/keys/my.pem --format private

> Note, Only key metadata can be retrieved for the private key data.

