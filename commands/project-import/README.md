Use **project-import** to load a project archive to the specified
rundeck instance.

Examples
--------

Import a project archive "qa1.archive" to an instance rundeck2:4440:

    rerun rundeck-admin:project-import --project qa1 --archive qa1.archive \
        --url http://rundeck2:4440 \
        --user admin --password admin 
