set :rails_env, 'production'
set :branch, "master"
set :deploy_to, '/home/api/staging'
set :rvm_type, :user

server 'ip-172-31-15-101.ec2.internal',
  user: 'api',
  roles: %w{app db},
  ssh_options: {
    proxy: Net::SSH::Proxy::Command.new('ssh -W %h:%p deploy@secure.windfall.me')
  }
