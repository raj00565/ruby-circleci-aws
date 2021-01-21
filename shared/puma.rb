#!/usr/bin/env puma

bind 'unix:///home/cryo/SET_APP_NAME_HERE/shared/tmp/sockets/puma.sock'
directory '/home/cryo/SET_APP_NAME_HERE/'
rackup "/home/cryo/SET_APP_NAME_HERE/config.ru"
pidfile "/home/cryo/SET_APP_NAME_HERE/shared/tmp/pids/puma.pid"
state_path "/home/cryo/SET_APP_NAME_HERE/shared/tmp/pids/puma.state"
stdout_redirect '/home/cryo/SET_APP_NAME_HERE/shared/log/puma_access.log', '/home/cryo/SET_APP_NAME_HERE/shared/log/puma_error.log', true

environment 'production'
threads 4,16
workers 4

preload_app!
prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/cryo/SET_APP_NAME_HERE/Gemfile"
end

# Required for preload_app!
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
