require 'serverspec'
require 'net/ssh'

set :backend, :ssh

# retrieve the hostname
host = ENV['TARGET_HOST']
puts "host =  '#{host}'"

# configure options for SSH
options = Net::SSH::Config.for(host)
set :host,        options[:host_name] || host
options[:auth_methods]  = ['password']

# if the LOGIN_USER environment variable exists, use it, otherwise use the current user name
if ENV['LOGIN_USER']
    options[:user] = ENV['LOGIN_USER']
else
    options[:user] ||= Etc.getlogin
end

# and apply our SSH options
set :ssh_options, options

# Disable sudo
set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
