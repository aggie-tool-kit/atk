### Pre-Alpha v1 Version
- info.yaml parser
    - get basic OS detection working
    - be able to generate a list of the atk dependences with their versions
    - be able to generate a list of the project commands
- user interface
    - Decide on the ATK command names
- toolbox
    - get the mac package manager working for
        - install
        - uninstall
    - get a skeleton for ubuntu
- atk-setup
    - Get the ATK command names into the system path on Mac
    - create a one-liner for mac
- user interface
    - Be able to run the `project run __ command` and it work

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
- create a !eval/language/ruby type that will instant eval itself and treat the evaluation as the value