The installer is a one-time program for setting up ATK on a new machine
There should be a one-liner CMD argument for each of the big three OS's

It needs to download these files from `interface/`
- atk
- project
- core.yaml

It needs to create an atk folder in `File.join(Etc.getpwuid.dir, "atk", "core.yaml")`

It needs all of the following dependencies:
- ruby 2.4
- the "atk_toolbox" ruby-gem
- a traditional package manager (homebrew, scoop, apt, pacman, yum)
- git
- python 3.7
- the pip package "ruamel.yaml"

The installer should create a new folder `atk-bin`, then add that folder as a low-priority section of the system path
    To do this on unix, edit `/etc/paths` and add the `atk-bin` section

Add the `project` and `atk` exectuables somewhere in the path


Somehow (not sure the best way) create the following commands
- atk
- project
- install
- uninstall
- add
- remove
- @
- \--
The ideal way would probably to create them as executables and add them to the path so that different unix shells wouldn't matter


Then in the user's home directory, create an info.yaml, add an atk-settings key
fill it out with the default values

