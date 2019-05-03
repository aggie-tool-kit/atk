require 'safe_yaml'
@data = YAML.load_file("./info.yaml", :safe => true)

