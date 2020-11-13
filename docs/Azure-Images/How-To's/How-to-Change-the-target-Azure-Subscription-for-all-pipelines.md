[[_TOC_]]


----


# Steps 

## 1 - Removing the old service connection

Go to `project settings` and then in the Pipelines section should be `Service Connections`

Select the `Deployment Subscription Service Connection`

> It is good practise to leave a description with the details of the service connection such as the subscription id and its name. You can always copy this to the clipboard and save it somewhere in case you wish to revert, but keep in mind this is manual.

Select the more icon, and select `delete`


## 2 - Create a new service connection

Create a new service connection by clicking `New service connection`.

Select `Azure Resource Manager` and hit next.

Easiest option is to select `service principal (automatic)`, this will use your azure devops account to automatically create a service principal, so make sure that you have **owner** permissions to that subscription.

Select the subscription, give the service connection name the title:

`Deployment Subscription Service Connection`

Include in the description the subscription id and the name of the connection. 

Ensure that "Grant access permission to all pipelines" is enabled, or you will have to allow each one in the pipeline one-by-one! 