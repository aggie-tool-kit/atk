class PackageManager
    def self.installed?(app_name, version=nil)
        puts 'This has not been implemented yet'
    end

    def self.install(app_name, version=nil)
        puts 'This has not been implemented yet'
    end

    def self.uninstall(app_name, version=nil)
        puts 'This has not been implemented yet'
    end

    def self.update_app(app_name)
        puts 'This has not been implemented yet'
    end
end

class Scoop < PackageManager

    @@scoop_dir = ENV['SCOOP'] or '#{Dir.home}/scoop'
    @@scoop_global_dir = ENV['SCOOP_GLOBAL'] or '#{ENV["ProgramData"]}/scoop'

    def self.base_dir(global=false)
        return global ? @@scoop_global_dir : @@scoop_dir
    end

    def self.apps_dir(global=false)
        root = base_dir(global)
        return '#{root}/apps'
    end 

    def self.app_dir(app_name, global=false)
        root = apps_dir(global)
        return '#{root}/#{app_name}'
    end

    def self.add_bucket(bucket_name, bucket_location=nil)
        if (bucket_location == nil) 
            `scoop bucket add #{bucket_name}`
        else
            `scoop bucket add #{bucket_name} #{bucket_location}`
        end
    end

    def self.switch_app_version(app_name, version=nil)
        if(version == nil)
            `scoop reset #{app_name}`
        else
            `scoop reset #{app_name}@#{version}`
        end
    end

    # Overriden Methods

    def self.installed?(app_name, version=nil) 
        # if(global == nil) { return (installed?(app_name, true) or installed? (app_name, false)) }
        # Dependencies of the format "bucket/dependency" install in a directory of form
        # "dependency". So we need to extract the bucket from the name and only give the app
        # name to is_directory
        # TODO: add support for checking if version is installed
        app_name = app_name.split("/")[-1]
        return File.directory?(File.expand_path(app_dir(app_name)))
    end

    def self.install(app_name, version=nil) 
        if(installed?(app_name))
            puts 'You already have #{app_name} installed'
            return
        end

        if(version == nil)
            `scoop install #{app_name}`
        else
            `scoop install #{app_name}@#{version}`
        end
    end

    def self.uninstall(app_name, version=nil)
        if(app_name == 'scoop')
            puts 'You are trying to uninstall scoop which is a dependency for ATK. We will not let you uninstall Scoop through ATK'
            return
        end

        if(version == nil)
            `scoop uninstall #{app_name}`
        else
            `scoop uninstall #{app_name}@#{version}`
        end
    end

    def self.update_app(app_name)
        `scoop update #{app_name}`
    end
end

class Homebrew < PackageManager

end

class Apt < PackageManager

end

class Pacman < PackageManager

end

class Yum < PackageManager

end