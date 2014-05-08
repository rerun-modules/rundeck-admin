Use **key-content** to print the key data content to the specified path.


The `--keypath <>` option specifies the path to store the key content.

> Note, the key-content command does not print private key content. Insted, only the metdata for the key will be printed.

Examples
--------

Print the public key data stored as my.pub in the path: /alexh/keys/my.pub:

    rerun rundeck-admin:key-content --keypath /alexh/keys/my.pub 

The public key content:

    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJlx56tM8phnuVT53aVn8zOXMw27zK/K7vodsAk5ELwTcAhSkipGQr2q5Px8L11bnGTFRiFQhdk1Ez7RsJR9nVG/s9mWQ5FL6/obCoQ09h69rIUO/rsp97dhlRFu7Awjp+hnM6TDOrzK5rRrsBRtAm5FS0V8oI7lNoIzJaot3AocRHQgI/3YaOj4gKMftCMDEiBGBr7yJHrbVKxMxSSi6tcqxcb8aLXFZyxGn8GzURnJHmQmbcdEcJCyHHy/L2lQdjQ/+Q+of1H7MRbU/2MJrHOMZ41c29i1gjYanL1lDGJyRtKQMOzkXVPqpCT9+K5lPE7b30p1GQsL90A5NDcyfj alexh@strongbad




