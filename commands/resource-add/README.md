Use **resource-add** to add a node to the project resource model.

The `--model` option specifies the model information for the node.
The model must be specified as a single string.
Each node property in the model is specified using a *-property value* pattern. Two
properties are required: -name and -description.

Specify other properties by prefixing a leading dash. For example
to declare that foo=bar for a node, say: "--model '-foo bar'".

Examples
--------

Add a node named "skippy" to the "examples" project:

    rerun rundeck-admin: resource-add --user admin --password admin --url http://localhost:4440 \
         --project examples \
         --model "-name skippy -description 'skip to the loo' -tags fun,simple -hostname skippy.local -foo bar -osFamily unix"

After adding the node, you can get the model back using *resource-get*:

    rerun rundeck-admin: resource-get --user admin --password admin --url http://localhost:4440 \
         --project examples --resource skippy

    skippy:
      osFamily: unix
      tags: fun, simple
      username: alexh
      foo: bar
      osVersion: 
      description: skip to the loo
      nodename: skippy
      hostname: skippy.local

