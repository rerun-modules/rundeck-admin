Use **jobs-archive** to create an archive of job definitions suitable for import with project-import.

The `--dir <>` option specifies the directory to look for jobs. Any jobs in subdirectories
will also be included.
If no `--dir <>` is specified, the current working directory is used.    

Job definitions must be files in [Job XML format](http://rundeck.org/docs/manpages/man5/job-v20.html). Job definitions can contain more than one job. This command specifically checks
a /joblist/job/name element in the job definition files.


Examples
--------
Assume a directory structure with two job definition files:

    /tmp/myjobs
      |-- job-1.xml
      `-- subdir
           `-- job-2.xml

Create an archive called "myjobs.zip" from any jobs found in directory "/tmp/myjobs":

    rerun rundeck-admin: jobs-archive --archive myjobs.zip --dir /tmp/myjobs

If `--archive <>` is unspecified, the archive file name will default to the name of the directory.

    rerun rundeck-admin: jobs-archive --dir /tmp/myjobs

Will produce an archive called "myjobs.zip".

With out any options, the command will look for jobs in the current working dirctory:

    cd /tmp/myjobs
    rerun rundeck-admin: jobs-archive 
    ls -l myjobs.zip
