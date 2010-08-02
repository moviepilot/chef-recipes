#!/usr/bin/env ruby
if !system("which ch 2>/dev/null >/dev/null")
  puts "ch is not in your PATH available ... add it with:\n\texport PATH=$PATH:#{`readlink -f $(dirname #{__FILE__})`}\n"
  exit 1
end

require 'rubygems'
require 'json'

CURRENT_RECIPE=`ls -1 /root/scalarium-agent/log/chef/*.json | tail -n 1`.strip
TMP_RECIPE_PATH="/tmp"
CHEF_EXECUTABLE="/root/scalarium-agent/bin/chef-solo -c /root/scalarium-agent/config/solo.rb -j" 

config_data = JSON.load(File.read(CURRENT_RECIPE))



if ARGV.size == 0 || ARGV[0] == "help" 
  puts <<EOF



Usage: #{ARGV[0]} command
  
  commands:
    ls              list the chef recipes of the current config
    exec <recipes>  only execute the specified recipes (separate by comma without blanks)  



EOF

elsif ARGV[0] == "ls"
  puts "recipes:"
  puts 
  puts "\t#{config_data["recipes"].join("\n\t")}"
  puts 

  puts "custom recipes:"
  puts 
  puts "\t#{config_data["scalarium_custom_cookbooks"]["recipes"] ? config_data["scalarium_custom_cookbooks"]["recipes"].join("\n\t") : "\tnone"}"

elsif ARGV[0] == "exec"
  if ARGV.size == 1
    command = "#{CHEF_EXECUTABLE} #{CURRENT_RECIPE}"

    puts "executing current chef config:"
    puts "\t#{command}\n\n"

    system(command)
    puts "\n\n\n\n\n************************************** finished executing command:\n\t#{command}\n\n"
  else
    recipes = ARGV[1].split(",")
    tmp_recipe = "#{TMP_RECIPE_PATH}/chef_config__#{ARGV[1].gsub("::", "-").gsub(",", "__")}.json"
    
    config_data["recipes"] = config_data["recipes"].select{|x| recipes.include?(x)}
    config_data["scalarium_custom_cookbooks"]["recipes"] = config_data["scalarium_custom_cookbooks"]["recipes"].select{|x| recipes.include?(x)}

    if not config_data["scalarium_custom_cookbooks"].empty?
      config_data["recipes"] << "scalarium_custom_cookbooks::load"
      config_data["recipes"] << "scalarium_custom_cookbooks::execute"
    end

    f = File.open(tmp_recipe, "w")
    f << config_data.to_json
    f.close

    command = "#{CHEF_EXECUTABLE} #{tmp_recipe}"
    puts "executing temporary chef config:"
    puts "\t#{command}\n\n"

    system(command)
    puts "\n\n\n\n\n************************************** finished executing command:\n\t#{command}\n\n"
  end
end
