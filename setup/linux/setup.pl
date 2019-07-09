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

sub ruby_version {
    my $version = `ruby -v`;
    # reduce it down to just the numbers
    $version =~ s/.+?(\d.+?) .+/$1/;
    return $version;
}

sub has_ruby_that_is_at_least {
    # check if ruby is avalible
    if (is_a_command("ruby")) {
        my $version = ruby_version();
        if ($version =~ /(\d+)\.(\d+)\./) {
            my $major_number = int($1);
            my $minor_number = int($2);
            if ($major_number lt $_[0]) {
                return undef;
            } elsif ($minor_number lt $_[1]) {
                return undef;
            } else {
                return 1;
            }
        }
    }
}
my $message = <<"END_MESSAGE"
    alkdjfjf
END_MESSAGE

# check if ruby exists
if (has_ruby_that_is_at_least(2,4)) {
    # run the ruby setup 
    system "curl "
} else {
    # if ubuntu, install ruby
    if (is_a_command("apt-get")) {
        system "sudo apt-get install ruby <<<\"Y\"";
    }
}

if ($^O eq "linux") {
    system("command -v ruby")
} elsif ($^O eq "darwin") {
    is_a_command("ruby");
} else {
    print "Wtf, what operating system are you running this on?";
}
