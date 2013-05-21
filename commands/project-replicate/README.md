Use *project-replicate* to replicate a project from one
rundeck to another one.
If the project does not exist on the target rundeck,
it will be automatically created for you.

*Warning*: Projects automatically created in the target rundeck do
not contain project configuration you might need. This might
be resource model setup or plugin configurations.

Examples:
---------

**Replicate one project**

Replicate a project named 'qa1' from an instance "rundeck1" to 
a target instance on "rundeck2":

    rerun rundeck-archive:project-replicate --project 'qa1' \
        --url http://rundeck1:4440 \
        --to-url http://rundeck2:4440 \
        --user admin --password admin

**Replicate multiple projects**

Imagine a rundeck that has 5 projects, [qa1 qa2 prod2 stage1 stage2],
and you want to replicate just the projects that begin with the
characters "qa". Below `qa[12]` is used to match both qa1 and qa2:

    rerun rundeck-archive:project-replicate --project 'qa[12]' \
        --url http://rundeck1:4440 \
        --to-url http://rundeck2:4440 \
        --user admin --password admin
