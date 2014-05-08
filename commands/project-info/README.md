Use **project-info** to dump the configuration settings for a project.

Supported Formats: (See [API docs](http://rundeck.org/2.1.0/api/index.html#put-project-configuration) for details)

* xml
* json
* plain

Examples
--------

Get the configuration info for a project called "fun":

    rerun rundeck-admin:project-info --project fun --format xml \
        --url http://rundeck1:4440 --user admin --password admin
