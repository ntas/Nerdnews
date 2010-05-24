set :application, "nerdnews"
set :scm, :git
set :repository,  ""
set :branch, "master"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/rails/#{application}"

role :app, ""
role :web, ""
role :db,  "", :primary => true

# Passenger restarts
namespace :deploy do
  task :start, :roles => :app do 
  end 
  task :stop, :roles => :app do 
  end 
  task :restart, :roles => :app do 
    run "touch #{release_path}/tmp/restart.txt" 
  end
end

desc "Symlink the DB config file from shared directory to current"
task :symlink_database_yml do
  run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

after 'deploy:update_code', 'symlink_database_yml'
