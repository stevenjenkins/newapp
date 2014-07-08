load 'deploy/assets'

set :application, "synaptian.com"
set :repository,  "git@github.com:stevenjenkins/newapp.git"

set :scm, :git
set :user, "synaptian.com"
set :deploy_to, "/home/#{user}/apps/#{application}"

set :use_sudo, false

# initialize rvm by using a login shell
default_run_options[:shell] = '/bin/bash --login'

role :web, "104.131.230.81"
role :app, "104.131.230.81"
role :db, "104.131.230.81"
role :web, "104.131.230.81", :primary => true

set :keep_releases, 5
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
