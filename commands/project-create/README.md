Use **project-create** to create a project in the specified rundeck.

Examples
--------

Create a project called "qa1":

    rerun rundeck-admin:project-create --project qa1 \
        --url http://rundeck1:4440 \
        --user admin --password admin
