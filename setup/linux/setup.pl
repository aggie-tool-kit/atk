#!/usr/bin/perl
use strict;
use warnings;

sub is_a_command {
    my $command_name = $_[0];
    my $output = `command -v $command_name`;
    if ($output =~ /.+/) {
        return $output;
    } else {
        return undef;
    }
}

if ($^O eq "linux") {
    system("command -v ruby")
} elsif ($^O eq "darwin") {
    is_a_command("ruby");
} else {
    print "Wtf, what operating system are you running this on?";
}
