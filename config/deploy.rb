##set :application, "set your application name here"
##set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

##role :web, "your web-server here"                          # Your HTTP server, Apache/etc
##role :app, "your app-server here"                          # This may be the same as your `Web` server
##role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
##role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

#self added lines
load 'deploy' if respond_to?(:namespace) # cap2 differentiator
                                         # Uncomment if you are using Rails' asset pipeline

load 'deploy/assets'

Dir['vendor/gems/*/recipes/*.rb', 'vendor/plugins/*/recipes/*.rb'].
    each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

# be sure to change these
set :user, 'ruslanimos'
set :domain, 'depot.pragprog.com'
set :application, 'depot'
# adjust if you are using RVM, remove if you are not
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user
# file paths
set :repository, "#{user}@#{domain}:git/#{application}.git"
set :deploy_to, "/home/#{user}/#{domain}"
# distribute your applications across servers (the instructions below put them
# all on the same server, defined above as 'domain', adjust as necessary)
role :app, domain
role :web, domain
role :db, domain, :primary => true
# you might need to set this if you aren't seeing password prompts
# default_run_options[:pty] = true
#As Capistrano executes in a non-interactive mode and therefore doesn't cause
#any of your shell profile scripts to be run, the following might be needed
#if (for example) you have locally installed gems or applications. Note:
#this needs to contain the full values for the variables set, not simply
#the deltas.
#default_environment['PATH']='<your paths>:/usr/local/bin:/usr/bin:/bin'
#default_environment['GEM_PATH']='<your paths>:/usr/lib/ruby/gems/1.8'
# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
   end
end

after "deploy:update_code", :bundle_install

desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end