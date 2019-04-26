scoopDir = ENV['SCOOP'] or '~/scoop'
scoopGlobalDir = ENV['SCOOP_GLOBAL'] or '#{ENV["ProgramData"]}/scoop'

def baseDir(global=false)
    return global ? scoopGlobalDir : scoopDir
end

def appsDir(global=false)
    root = baseDir(global)
    return '#{root}/apps'
end 

def appDir(appName, global=false)
    root = appsDir(global)
    return '#{root}/#{appName}'
end

def installed(appName, global=nil) {
    if(global == nil) { return (installed(appName, true) or (installed (appName, false))) }
    # Dependencies of the format "bucket/dependency" install in a directory of form
    # "dependency". So we need to extract the bucket from the name and only give the app
    # name to is_directory
    appName = appName.split("/")[]
    return File.directory?(File.expand_path(appDir(appName, global)))
}