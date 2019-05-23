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
    def self.version
        raise "not yet implemented"
    end
    
    def self.is?(adjective)
        # summary:
            # this is a function created for convenience, so it doesn't have to be perfect
            # you can use it to ask about random qualities of the current OS and get a boolean response
        # convert to string (if its a symbol)
        adjective = adjective.to_s
        case adjective
            when 'windows'
                return (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
            when 'mac'
                return (/darwin/ =~ RUBY_PLATFORM) != nil
            when 'linux'
                return (not OS.is?(:windows)) && (not OS.is?(:mac))
            when 'unix'
                return OS.is?(:windows) || OS.is?(:mac)
        end
    end
end