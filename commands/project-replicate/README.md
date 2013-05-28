Use *project-replicate* to replicate a project from one
rundeck to another one. Project replication is done by exporting
a project to an archive and then importing the archive to
another Rundeck instance.
If the project does not exist on the target rundeck,
it will be automatically created for you.

+ *Warning*: Projects automatically created in the target rundeck do
not contain project configuration you might need. This might
be resource model setup, aclpolicy or plugin configurations.

+ *Note*: This command is not meant as a tool to synchronize
two rundecks in real time. If more instantaneous replication
is needed consider setting up a database like mysql and 
use database replication.

Examples:
---------

**Replicate one project**

Replicate a project named 'qa1' from an instance "rundeck1" to 
a target instance on "rundeck2":

    rerun rundeck-admin: project-replicate --project 'qa1' \
        --url http://rundeck1:4440 \
        --to-url http://rundeck2:4440 \
        --user admin --password admin

**Replicate multiple projects**

Multiple projects can be specified by using a regex pattern.
Imagine a rundeck that has 5 projects, [qa1 qa2 prod2 stage1 stage2],
and you want to replicate just the projects that begin with the
characters "qa". Below `qa[12]` is used to match both qa1 and qa2:

    rerun rundeck-admin: project-replicate --project 'qa[12]' \
        --url http://rundeck1:4440 \
        --to-url http://rundeck2:4440 \
        --user admin --password admin
