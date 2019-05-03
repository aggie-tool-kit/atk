# every OS version is a perfect heirarchy of versions and sub verisons that may or may not be chronological
# every OS gets it's own custom heirarchy since there are issues like x86 support and "student edition" etc
# the plan is to release this heirarchy on its own repo, and to get pull requests for anyone who wants to add their own OS
os_heirarchy = {
    "windows" => {
        "10"    => {},
        "8.1"   => {},
        "8"     => {},
        "7"     => {},
        "vista" => {},
        "xp"    => {},
        "95"    => {},
    },
    "mac" => {
        "mojave"         => {},
        "high sierra"    => {},
        "sierra"         => {},
        "el capitan"     => {},
        "yosemite"       => {},
        "mavericks"      => {},
        "mountain lion"  => {},
        "lion"           => {},
        "snow leopard"   => {},
        "leopard"        => {},
        "tiger"          => {},
        "panther"        => {},
        "jaguar"         => {},
        "puma"           => {},
        "cheetah"        => {},
        "kodiak"         => {},
    },
    "ubuntu"     => {},
    "arch"       => {},
    "manjaro"    => {},
    "deepin"     => {},
    "centos"     => {},
    "debian"     => {},
    "fedora"     => {},
    "elementary" => {},
    "zorin"      => {},
    "raspian"    => {},
    "android"    => {},
}

# 
# Groups
# 
# the groups are the pratical side of the OS, they describe the OS rather than fit it prefectly into a heirarchy
module OS
    # TODO: have the version pick one of the verions in the os_heirarchy according to the current OS
    def version
        raise "not yet implemented"
    end
    
    def mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
    end
    
    def windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end
    
    def unix?
        not self.windows?
    end

    def linux?
        (not self.windows?) && (not self.mac?)
    end
    
    def arch_based?
        raise "not yet implemented"
    end
    
    def debian_based?
        raise "not yet implemented"
    end
end