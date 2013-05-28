Use **project-list** to list all projects in the specified rundeck.

Examples
--------

List the projects on rundeck1:

    rerun rundeck-admin:project-list --url http://rundeck1:4440 \
        --user admin --password admin 

Each project is listed on a separate line:

     qa1
     qa2
     prod1
     prod2
     stage1
