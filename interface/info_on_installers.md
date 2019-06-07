# How installers work
There are 3 levels of installers
- core
- approved
- unapproved


### Core
The core installers are maintained in seperate repos by atk
Their names and versions are manually added to the `core.yaml` file which is used to lookup if a core package exist
Each one also has a folder that contains all of versions, with each version being a compressed folder
Every compressed version folder is named according to its version
For now, every version is 3 integers seperated by periods
(Eventually there will be support for having text/names in the versioning)
Each one has an info.yaml has a:
```yaml
(installer):
    (versions_folder): # relative path (in unix format) to the versions
```
Within each version folder there is an info.yaml that has:
```yaml
(installer):
    (install_command): # ex: `ruby install_stuff.rb`
    (dependencies):
```
This `(installer)` field can have `when()` fields such as `when(--os is 'mac')` 


### Approved
The approved repos don't have to keep a folder of all their versions. Instead they specify a version in their info.yaml and then ATK will record their version when it is published.


### Unapproved
Unapproved are nearly identical to the core packages. The only difference is they are not on the `core.yaml` list and there is no publishing process.