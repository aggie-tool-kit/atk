#!/usr/bin/perl
use strict;
use warnings;

if ($^O eq "linux") {
    print "TODO: add support for installing ruby on ubuntu and arch"
    system("echo hello")
} else {
    print "Wtf, what operating system are you running this on?"
}
