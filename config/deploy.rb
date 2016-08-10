require 'net/ssh/proxy/command'

# config valid only for Capistrano 3.1
lock '3.5.0'

set :application, 'windfall-licensing-admin'
set :repo_url, 'git@github.com:windfall-labs/windfall-licensing-admin.git'
set :deploy_via, :remote_cache
set :bundle_without, [:development, :test]

set :log_level, :debug
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle}

set :keep_releases, 1
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_flags, '--deployment'

set :rvm_ruby_version, '2.3.1@windfall-licesing-admin'


load "config/deploy/tasks.rb"

# set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  after :publishing, :restart
end
