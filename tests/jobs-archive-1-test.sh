#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-admin -p jobs-archive [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "jobs-archive"

# Global settings.
# ----------------

# Tests.
# ------

it_fails_if_no_job_files_found() {

	empty_dir=$(mktemp -d "/tmp/empty.XXXX")

	! rerun rundeck-admin: jobs-archive --dir $empty_dir --archive empty.zip
	! test -f empty.zip

	rmdir $empty_dir
}

it_archives_job_file_dirs_recursively() {

	jobs_dir=$(mktemp -d "/tmp/jobs.XXXX")

	# job file 1
	cat > $jobs_dir/job1.xml <<EOF
<joblist>
  <job>
    <id>1946fe1c-93f0-4d67-8ddf-6d263bbb2ce4</id>
    <loglevel>INFO</loglevel>
    <sequence keepgoing='false' strategy='node-first'>
      <command>
        <exec>echo hi</exec>
      </command>
    </sequence>
    <description></description>
    <name>hi2</name>
    <context>
      <project>examples</project>
    </context>
    <uuid>1946fe1c-93f0-4d67-8ddf-6d263bbb2ce4</uuid>
  </job>
  <job>
    <id>1946fe1c-93f0-4d67-8ddf-6d263bbb2ce5</id>
    <loglevel>INFO</loglevel>
    <sequence keepgoing='false' strategy='node-first'>
      <command>
        <exec>echo blar</exec>
      </command>
    </sequence>
    <description></description>
    <name>blar</name>
    <context>
      <project>examples</project>
    </context>
    <uuid>1946fe1c-93f0-4d67-8ddf-6d263bbb2ce5</uuid>
  </job>
</joblist>
EOF
	# job file 2, in a subdirectory
	mkdir -p $jobs_dir/subdir
	cat > $jobs_dir/subdir/job2.xml <<EOF
<joblist>
  <job>
    <id>9448156e-1bd5-43af-8f24-4d866143ee9c</id>
    <loglevel>INFO</loglevel>
    <sequence keepgoing='false' strategy='node-first'>
      <command>
        <exec>echo hi</exec>
      </command>
    </sequence>
    <description></description>
    <name>hi</name>
    <context>
      <project>examples</project>
    </context>
    <uuid>9448156e-1bd5-43af-8f24-4d866143ee9c</uuid>
  </job>
</joblist>
EOF
	
	# create the archive and check it's created.
	archive_dir=$(mktemp -d "/tmp/archive.dir.XXXX")
	rerun rundeck-admin: jobs-archive --dir $jobs_dir --archive $archive_dir/archive.zip
	test -f $archive_dir/archive.zip

	# unzip it to confirm the content of the archive.
	extract_dir=$(mktemp -d "/tmp/archive-extract.XXXXX")
	unzip -d $extract_dir $archive_dir/archive.zip
	cd $extract_dir
	# check the manifest.
	test -f META-INF/MANIFEST.MF
	vers=$(awk -F: '/Rundeck-Archive-Format-Version/ {print $2}' META-INF/MANIFEST.MF)
	# strip whitespace from the value.
	test "${vers//[[:space:]]/}" = 1.0
	# check the job content. Job files are listed by count.
	test -d rundeck-archive/jobs
	test -f rundeck-archive/jobs/job-0.xml
	nJobs=$(xmlstarlet sel -t -v "count(//job)"  rundeck-archive/jobs/job-0.xml)
	test "$nJobs" = 2
	test -f rundeck-archive/jobs/job-1.xml; # the job def in a subdirectory.

	# check the required (but empty reports and executions directories).
	test -d rundeck-archive/reports
	[ $(ls -A rundeck-archive/reports) ] && exit 1
	test -d rundeck-archive/executions
	[ $(ls -A rundeck-archive/executions) ] && exit 1

	# Looks good. Clean up the test data.
	rm -r $jobs_dir $extract_dir $archive_dir
}

it_ignores_bogus_xml_files() {
  jobs_dir=$(mktemp -d "/tmp/jobs.XXXX")
  archive_dir=$(mktemp -d "/tmp/archive.dir.XXXX")
  extract_dir=$(mktemp -d "/tmp/archive-extract.XXXXX")

  # Legit job definition.
  cat > $jobs_dir/job1.xml <<EOF
<joblist>
  <job>
    <name>job1</name>
  </job>
</joblist>
EOF

  # Bogus job definition.
  cat > $jobs_dir/fun.xml <<EOF
<fun>
  <haha/>
</fun>
EOF

  # Archive the definitions. Only the legit one should be in the archive.
  rerun rundeck-admin: jobs-archive --dir $jobs_dir --archive $archive_dir/archive.zip
  unzip -d $extract_dir $archive_dir/archive.zip
  cd $extract_dir  
  files=( rundeck-archive/jobs/* )
  test ${#files[*]} -eq 1
  test "job1" = $(xmlstarlet sel -t -m /joblist/job -v name rundeck-archive/jobs/job-0.xml)

  # Clean up the test data.
  rm -r $jobs_dir $extract_dir $archive_dir
}

