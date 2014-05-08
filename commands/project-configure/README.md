Use **project-configure** to replace all configuration settings
for the specified project. 

Supported Formats: (See [API docs](http://rundeck.org/2.1.0/api/index.html#put-project-configuration) for details)

* xml
* json
* plain

Examples
--------

Use **project-info** to dump out configuration or produce your own. 
Here's an XML example config file for a project called "fun":

File listing: `fun.xml`

	<config>
	  <property key='project.name' value='fun' />
	  <property key='resources.source.1.config.requireFileExists' value='false' />
	  <property key='test.property' value='test value' />
	  <property key='project.ssh-authentication' value='privateKey' />
	  <property key='project.ssh-key-storage-path' value='keys/ssh/alexsolaris.pem' />
	  <property key='service.NodeExecutor.default.provider' value='jsch-ssh' />
	  <property key='resources.source.1.config.includeServerNode' value='true' />
	  <property key='resources.source.1.config.generateFileAutomatically' value='true' />
	  <property key='resources.source.1.config.file' value='/var/rundeck/projects/fun/etc/resources.xml' />
	  <property key='project.ssh-keypath' value='/var/lib/rundeck/.ssh/id_rsa' />
	  <property key='service.FileCopier.default.provider' value='jsch-scp' />
	  <property key='project.description' value='fun' />
	  <property key='resources.source.1.type' value='file' />
	</config>

Load the config file data:

    rerun rundeck-admin:project-configure --project fun --file fun.xml --format xml \
        --url http://rundeck1:4440 \
        --user admin --password admin 

