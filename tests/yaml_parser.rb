require_relative '../toolbox/yaml_info_parser.rb'

Dir.chdir __dir__ # switch to the current directory

puts Info.project['auto_generated_commands']