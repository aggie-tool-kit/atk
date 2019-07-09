#!/usr/bin/perl
use strict;
use warnings;

print "starting perl script\n";

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


sub install_ruby {
    # if ubuntu, install ruby
    if (is_a_command("apt-get")) {
        system "sudo apt-get install ruby <<<\"Y\"";
    } else {
        die "Sadly your distro isn't supported yet :/";
    }
}

# 
# require ruby
# 
if (not has_ruby_that_is_at_least(2,4)) {
    install_ruby();
}
# install the atk_toolbox gem
system "sudo gem install atk_toolbox";

# 
# run the ruby script
# 
system "ruby setup.rb"