Use **project-export** to export a project into an archive you
can import using `project-import`. If no `--archive` option
is specified one will be written to the current working directory.

Examples
--------

Export a project called "qa1" to a file "qa1.archive":

    rerun rundeck-admin:project-export --project qa1 --admin qa1.archive \
        --url http://rundeck1:4440 \
        --user admin --password admin 
