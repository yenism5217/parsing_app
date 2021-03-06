require 'bundler/capistrano'

set :normalize_asset_timestamps, false
set :user, 'deploy'
set :domain, 'barkbest.declaring.it'
set :java_home, ENV['JAVA_HOME']#"/usr/lib/jvm/java-6-openjdk"
#set(:rake) { "JAVA_HOME=#{java_home} GEM_HOME=#{gem_home} RAILS_ENV=#{rails_env} /usr/bin/env rake" }
set :application, "parsing_app"

#set :repository, "." 
set :repository, "git@github.com:yenism5217/parsing_app.git"  # Your clone URL
#set :scm, :none
set :scm, "git"
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache

set :checkout, 'export'

set :scm_passphrase, "umdterpsU1"  # The deploy user's password
set :deploy_to, "/home/#{user}/#{domain}"
set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :web, domain                        # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:migrations", "deploy:cleanup"