salesforce-deploy
=================

A sample Salesforce.com deployment structure utilizing
[Apache Ant](http://ant.apache.org/) and the
[Force.com Migration Tool](https://developer.salesforce.com/page/Force.com_Migration_Tool).

This structure includes a build file with shorthand targets to easily interact
with the Migration Tool targets.  Key functions are ``deploy``, ``retrieve``,
``undeploy``, and ``test``. You can use this structure as a base for your
Salesforce deployments to quickly deploy files to your Salesforce org.

Getting Started
---------------

###System Requirements
1. **Apache Ant** - See [Installing Apache Ant](http://ant.apache.org/manual/install.html)
   for details.
1. **Force.com Migration Tool** - See
   [Installing the Force.com Migration Tool](http://www.salesforce.com/us/developer/docs/daas/Content/forcemigrationtool_install.htm)
   for details. By the end, you should have ``ant-salesforce.jar`` included in
   your Ant libraries.

###Contents
* **``undeploy``** - Sample structure for deleting files from a Salesforce
  org. Includes an empty ``package.xml`` and a ``destructiveChanges.xml``
  that lists the files to be deleted.
* **``unmanaged-pacakge-name``** - Sample files that make up an unmanaged
  package. The package name is defined in the ``fullName`` element of the
  ``package.xml``.
* **``unpackaged``** - Sample files that don't belong to a package.
* **``build.properties``** - Ant properties file for individual
  configurations (e.g. usernames and passwords).
* **``build.xml``** - Ant build file with shorthand targets to use the
  Force.com Migration Tool targets.
* **``manifiest.xml``** - Sample list of components used for retrieving
  Salesforce metadata.

###Configurables
List of configurable build properties from ``build.properties``:

* **``sf.username``** - Username for the org you will be deploying to /
  retrieving from.
* **``sf.password``** - Password + security token for the user you wish
  to login as for deploying/retrieving metadata.
* **``sf.serverurl``** - Login url for your Salesforce org type.  Prod/dev use
  <http://login.salesforce.com>, sandboxes use <http://test.salesforce.com>.
* **``deploy.dir``** - The directory containing the metadata to be deployed to
  your Salesforce org.  This folder includes a ``package.xml`` file that lists
  the metadata to be deployed.
* **``undeploy.dir``** - The directory containing the ``destructiveChanges.xml``
  file that lists the contents to be removed from your Salesforce org.
  Also contains an empty ``package.xml``.
* **``retrieve.dir``** - The directory to store metadata retrieved from your
  Salesforce org based on the contents of the ``manifiest.xml`` file.
* **``sf.packageName``** - Comma-separated list of package names to be retrieved
* **``sf.zipFile``** - Path of a zip file to be retrieved
* **``sf.metadataType``** = Metadata type name for bulk retrieval or listings

Usage
---------------
Run **``ant [target]``** from the ``deployment`` directory to utilize
the targets of the migration tool.

    Usage: ant [target]

    Available targets:
      deploy           Deploy contents of deploy.dir
      deployRunAll     Deploy contents of deploy.dir and run all tests
      deployZip        Deploy contents of sf.zipFile
      describe         Describe all metatdata types
      help, usage      Displays these usage guidelines
      list             List all information of items of metadata type
                       sf.metadataType
      retrieve         Retrieve contents of manifest.file
      retrieveBulk     Retrieve all instances of a given sf.metadataType
      retrievePackage  Retrieve contents of sf.packageName
      test             Test deploy contents of deploy.dir
      undeploy         Delete contents of destructiveChanges.xml

### Targets
Shorthand targets included in the build file.

#### deploy
Deploy unpacked metadata from specified ``deploy.dir`` directory. Optionally
specify which unit tests to run from this target.

#### deployRunAll
Deploy unpacked metadata from specified ``deploy.dir`` directory and run all
tests.

#### deployZip
Deploy a zip of metadata files specified in ``sf.zipFile`` to the org.

#### describe
Retrieve the information on all supported metadata types for your current org.

#### list
Retrieve the information of all items of a particular metadata type specified
by ``sf.metadataType``.

#### retrieve
Retrieve an unpackaged set of metadata from your org based on the contents of
``manifest.xml``.  Retrieved metadata is stored in the relative ``retrieve.dir``
directory.

#### retrieveBulk
Retrieve all the items of a particular metadata type defined by
``sf.metadataType``. Retrieved metadata is stored in the relative
``retrieve.dir`` directory.

#### retrievePackage
Retrieve metadata for all the packages specified under ``sf.packageName``.
Retrieved metadata is stored in the relative ``retrieve.dir`` directory.

#### test
Test deploy the contents of ``deploy.dir``.  This uses the provided username
and password and does a ``checkOnly`` deploy to your Salesforce org.

#### undeploy
Remove/Undeploy metadata specified in a ``destructiveChanges.xml`` file.

### Examples
1. **Test deploying files from the "unpackaged" folder**

    ```Shell
    $ ant test
    Buildfile: /Users/username/salesforce-deploy/deployment/build.xml

    test:
         [echo] Testing deploy of unpackaged as username@domain.com
    [sf:deploy] Request for a deploy submitted successfully.
    [sf:deploy] Request ID for the current deploy task: 09Si0000002tENSEA2
    [sf:deploy] Waiting for server to finish processing the request...
    [sf:deploy] Request Status: Pending
    [sf:deploy] Request Status: Succeeded
    [sf:deploy] *********** DEPLOYMENT SUCCEEDED ***********
    [sf:deploy] Finished request 09Si0000002tENSEA2 successfully.

    BUILD SUCCESSFUL
    Total time: 14 seconds
    ```

1. **Deploy files from the "unpackaged" folder**

    ```Shell
    $ ant deploy
    Buildfile: /Users/username/salesforce-deploy/deployment/build.xml

    deploy:
         [echo] Deploying unpackaged as username@domain.com
    [sf:deploy] Request for a deploy submitted successfully.
    [sf:deploy] Request ID for the current deploy task: 09Si0000003BSYyEAO
    [sf:deploy] Waiting for server to finish processing the request...
    [sf:deploy] Request Status: Pending
    [sf:deploy] Request Status: Succeeded
    [sf:deploy] *********** DEPLOYMENT SUCCEEDED ***********
    [sf:deploy] Finished request 09Si0000003BSYyEAO successfully.

    BUILD SUCCESSFUL
    Total time: 14 seconds
    ```

1. **Retrieving files listed in "manifest.xml" into a new "retrieve" folder**

    ```Shell
    $ ant retrieve
    Buildfile: /Users/username/salesforce-deploy/deployment/build.xml

    retrieve:
         [echo] Retrieving items in manifest.xml as username@domain.com.
        [mkdir] Created dir: /Users/username/salesforce-deploy/deployment/retrieve
    [sf:retrieve] Request for a retrieve submitted successfully.
    [sf:retrieve] Request ID for the current retrieve task: 09Si0000003BSZYEA4
    [sf:retrieve] Waiting for server to finish processing the request...
    [sf:retrieve] Request Status: InProgress
    [sf:retrieve] Request Status: Completed
    [sf:retrieve] Finished request 09Si0000003BSZYEA4 successfully.

    BUILD SUCCESSFUL
    Total time: 14 seconds
    ```
