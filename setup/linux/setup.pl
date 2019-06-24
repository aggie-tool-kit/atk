#!/usr/bin/perl
use strict;
use warnings;

if ($^O eq "linux") {
    print "TODO: add support for installing ruby on ubuntu and arch"
    system("cat /etc/os-release")
} elsif ($^O eq "darwin") {
    # just run the mac command
    system("eval `curl -L git.io/fjBzd`")
} else {
    print "Wtf, what operating system are you running this on?"
}
