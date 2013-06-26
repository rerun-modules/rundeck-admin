Use **project-remove** to remove a project in the specified rundeck.

*Note*: You must be on the rundeck server to run this command. It cannot be run remotely.

Examples
--------

Remove a project called "qa1":

    rerun rundeck-admin:project-remove --project qa1 \
        --url http://rundeck1:4440 \
        --user admin --password admin
