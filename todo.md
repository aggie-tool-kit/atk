- finish defining the package specs
    - create a github template for an installer
        - info.yaml # for project management commands
        - install
        - uninstall
- create a version comparison tool
- create an environment variable ATK that is a JSON object
    - have it contain all the info in the settings.yaml file
- create a way to set the ATK-installer-version variable
- create a way to keep a stack-frame-like recorder of the direct dependencies of an installer
- create the installer command that
    - check the version of the downloaded installer (which probably wont exist)
    - download the info.yaml of the remote installer, and check its installer version
    - if the installer version is newer, then download the whole repo
    - otherwise just use the downloaded installer
    - calls the atk_toolbox installer frame
    - downloads the info.yaml if there is one
        - checks the atk version
        - run the parser on the (installer):
        - this is the "standard installer key procedure":
            - if it is in the info.yaml
                - if it is a string, assume its !language/console
                - if it is !language/console then run it
                - if it is !language/ruby then run it
            - if its not in the yaml
                - try to download a file with that keyname + .rb and then run that
    - if there is no verison specified, then get the (latest_version)
        - if it is in info.yaml and it is a valid version (dot seperated numbers)
            - use that version
        - otherwise use the standard procedure
    - if the installed version is the same as the requested/latest
        - TODO: if this is a top-level call, ask if they'ed like to reinstall
        - if this is a recursive call, do nothing (finish)
    - if the requested version is older than then current one
        - if this is a recursive call
        - tell the user that a library asked for an older version but that its probably okay to use a newer one, and then ask if they'ed like to use the newer one
    - get the (dependencies)
        - if it is in info.yaml and it is a dict
            - then use that
        - otherwise follow standard prodecure for getting it
    - check the $DEPENDENCIES atk environment variable
        - if they're not on the pending set (which is a safety check for recursive dependencies) 
            - then recursively install them
    - for (on_install) follow standard prodecure
    - after install, remove the name from the pending set
    - pop the atk_toolbox installer frame to get a list of all the direct dependencies
    - add the installed version and its direct dependencies to `library.yaml`

- allow the commands key to be a script

- create an API for registering a new global command
    - create a github installer template for creating a new global command
- create an API for unzip/untaring a folder
- create an API for $HOME_DIR, and $TEMP_DIR

### Pre-Alpha v2 Version
- Be able to parse the info.yaml
    - figure out how to modify the info.yaml without screwing up the *keys
- toolbox 
    - get the package manager class/obj working for windows and linux for
        - install
        - uninstall
- atk-setup
    - Create a one liner for windows and linux (that does nothing)
    - Get the base dependencies installed on ubuntu (with the one-liner)
    - Get the system commands into ubuntu path (with the one-liner)
- user interface
    - Be able to run the `project run __` command and it work on ubuntu

### Pre-Alpha v3 Version
- atk-setup
    - Get the base dependencies working on windows
    - Get the system commands into windows
- user interface
    - Be able to run the `project run __` command and it work on windows

### Alpha Backlog
- Get the basics of the install command working
- Agree on the info.yaml for the home folder
- Create a small dummy installer for part of the core repo


### Beta Backlog
- Get a basics of a npm or pip package manager working
- Create a tool for printing output
- Create a tool for asking users questions


### Full Release Backlog
- Parsing info.yaml
    - generate a list of evironment variables
- Get setting ENV variables locally working
- Create tool for adding global aliases 
- Create tool for adding global ENV variables on linux/mac for bash only 
- Get the autocomplete of the !language/console working

### Version 2 Backlog
- Create tool for adding global ENV variables on linux/mac for zsh
- Create an uninstaller for ATK
- Get structures working
    - generate a list of structures and their version #'s

### unsorted
- create a javascript and python API of atk_toolkit 
- standardize the ruby version that is used on mac and linux
- figure out how to run a version.rb script without it modifying anything