
Use the `stubbs:test` command to to run test plans.

    rerun stubbs:test -m rundeck-admin -p jobs-archive-1

*Test plan sources*

* [jobs-archive-1](tests/jobs-archive-1.html)
  * it fails if no job files found
  * it archives job file dirs recursively
  * it ignores bogus xml files

