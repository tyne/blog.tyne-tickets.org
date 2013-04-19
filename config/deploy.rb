require "bundler/capistrano"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "tyne-tickets.org"
set :repository,  "git@github.com:tyne/blog.tyne-tickets.org.git"

set :scm, :git

role :web, "tyne-tickets.org"                          # Your HTTP server, Apache/etc
role :app, "tyne-tickets.org"                          # This may be the same as your `Web` server
role :db,  "tyne-tickets.org", :primary => true # This is where Rails migrations will run

set :branch, 'master'

set :deploy_via, :remote_cache
set :use_sudo, false
set :user, "app"
set :port, 22
set :git_enable_submodules, 1
set :deploy_to, "/home/#{user}/#{application}"

set :rvm_ruby_string, "1.9.3@tyne"

namespace :deploy do
  desc "Generate the site into the _site folder"
  task :generate do
    system "jekyll _site --no-auto"
  end

  desc "reloads nginx config"
  task :nginx_reload, :roles => :web do
    run "#{sudo} /etc/init.d/nginx reload"
  end
end

before "deploy", "deploy:generate"

before "deploy:restart", "deploy:nginx_reload"
