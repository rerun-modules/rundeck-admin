Use **resource-get** to get the resource model for the specified node.

Examples
--------

Get the resource named Targa.local:

    rerun rundeck-admin: resource-get --user admin --password admin \
       --url http://localhost:4440 --resource Targa.local
       
By default, the model comes back as XML:

    <?xml version="1.0" encoding="UTF-8"?>

    <project>
      <node name="Targa.local" description="Rundeck server node" tags="" 
        hostname="Targa.local" osArch="x86_64" osFamily="unix" 
        osName="Mac OS X" osVersion="10.8.3" username="alexh"/>
    </project>       

If you want yaml, use the --format option:

    rerun rundeck-admin: resource-get --user admin --password admin \
       --url http://localhost:4440 --resource Targa.local --format yaml

    Targa.local:
      osFamily: unix
      tags: ''
      username: alexh
      osArch: x86_64
      osVersion: 10.8.3
      description: Rundeck server node
      nodename: Targa.local
      hostname: Targa.local
      osName: Mac OS X
