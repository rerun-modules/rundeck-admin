Use **resource-add** to add a node to the project resource model.

The `--data` option specifies the model information for the node.
Each property is specified using a *-prop val* pattern. Two
properties are required: -name and -description.


Examples
--------

Add a node named "skippy" to the "examples" project:

    rerun rundeck-admin: resource-add --user admin --password admin --url http://localhost:4440 \
         --project examples --data "-name skippy -description 'skip to the loo' -osFamily unix -hostname skippy.local"
