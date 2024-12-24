require 'serverspec'

set :backend, :ssh


host = 'target'
options = Net::SSH::Config.for(host)
options[:user] = 'ec2-user'
#options[:keys] = ''
set :host, host
set :ssh_options, options