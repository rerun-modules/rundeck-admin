
Use **schedule-takeover** to tell a Rundeck server in 
cluster mode to claim all scheduled jobs from another cluster server.

INCUBATOR STATUS: This command may change, go away, or turn into something else.

Example
-------

The UUID option specifies the server uuid from which you want to takeover scheduling jobs.
You can obtain the server uuid from the framework.properties file:

    rundeck1 $ awk -F= '/rundeck.server.uuid/ {print $2}' /etc/rundeck/framework.properties

You should get back one line of output containing the UUID value:    
    
    1d9b13c5-782f-408b-999f-50451d4c5daf

Tell rundeck2 to takeover all jobs managed by rundeck1, using its UUID:

    rundeck2 $ rerun rundeck-admin:schedule-takeover --user admin --password --admin
        --url http://rundeck2:4440 --uuid 1d9b13c5-782f-408b-999f-50451d4c5daf
        
Output will show how many job schedules were taken over:

    Took over schedule for 2 jobs.
        
It is safe to run the command again.

    rundeck2 $ !!

No other jobs to take over.

    Took over schedule for 0 jobs.
