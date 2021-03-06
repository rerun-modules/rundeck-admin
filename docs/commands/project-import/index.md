[rundeck-admin](../../index.html)
# project-import 

Import a project archive.

## SYNOPSIS

    rerun rundeck-admin:project-import --project <> --url <$RUNDECK_URL> --user <$RUNDECK_USER> --password <$RUNDECK_PASSWORD> [--archive <>] [--retain-uuids <true>] [--import-executions <true>]

### OPTIONS

* [    --project <>: the project name.](../../options/project/index.html)
* [    --url <$RUNDECK_URL>: rundeck server url.](../../options/url/index.html)
* [    --user <$RUNDECK_USER>: the login user name.](../../options/user/index.html)
* [    --password <$RUNDECK_PASSWORD>: the login password.](../../options/password/index.html)
* [   [--archive <>]: the archive file.](../../options/archive/index.html)
* [   [--retain-uuids <true>]: Create Jobs with their defined UUIDs or a new UUID will be generated for each Job created.](../../options/retain-uuids/index.html)
* [   [--import-executions <true>]: Creates new Executions and History reports from the archive.](../../options/import-executions/index.html)

## README

Use **project-import** to load a project archive to the specified
rundeck instance.

Examples
--------

Import a project archive "qa1.archive" to an instance rundeck2:4440:

    rerun rundeck-admin:project-import --project qa1 --archive qa1.archive \
        --url http://rundeck2:4440 \
        --user admin --password admin 

## TESTS

Use the `stubbs:test` command to to run test plans.

    rerun stubbs:test -m rundeck-admin -p project-import

*Test plan sources*

* [project-import-1](../../tests/project-import-1.html)
  * it imports a project

## SCRIPT

To edit the command script for the rundeck-admin:project-import command, 
use the `stubbs:edit`
command. It will open the command script in your shell EDITOR.

    rerun stubbs:edit -m rundeck-admin -c project-import

*Script source*

* [script](script.html): `RERUN_MODULE_DIR/commands/project-import/script`

## METADATA

* `NAME` = project-import
* `DESCRIPTION` = "Import a project archive."
* `OPTIONS` = "project url user password archive retain-uuids import-executions"

----

*Generated by stubbs:docs Wed May 14 15:58:06 PDT 2014*

