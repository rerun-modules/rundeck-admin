Examples
--------

Import a project archive "qa1.archive" to an instance rundeck2:4440:

    rerun rundeck-admin:project-import --project qa1 --admin qa1.archive \
        --url http://rundeck2:4440 \
        --user admin --password admin 
