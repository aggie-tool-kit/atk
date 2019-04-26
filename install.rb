require_relative './installer_api'

# 
# Summary
# 
    # this is a one-time installer that sets up ATK for a specific operating system
    # it adds the following commands
        # atk
        # project
        # @ (alias to atk)
        # 
        # :: (alias to project run)
    
if OS.mac?
    if @Info["settings"] && @Info["settings"]["global_commands"]
        puts "You've already got things saved in settings"
    else
        # setup the colon command
        # TODO: create a standard way of doing this
        `touch ~/.bash_profile`
        `echo "alias ::='project run '" >> ~/.bash_profile`
        # TODO: create a standard way of doing this
        `echo "alias @='atk'" >> ~/.bash_profile`
        # record the setup in info.yaml
        data ||= {}
        data["settings"] ||= {}
        data["settings"]["global_commands"] ||= {}
        data["settings"]["global_commands"]["::"] = true
        data["settings"]["global_commands"]["@"] = true
        # TODO: abstract this out into an API
        File.write(Dir.home+'/info.yaml', data.to_yaml)
    end
end