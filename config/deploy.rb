require 'capistrano_colors'
require 'bundler/capistrano'
require 'capistrano-rbenv'
require 'dotenv/capistrano'

set :application, "blog"
set :repository,  "git@github.com:hogelog/blog.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "blog.hogel.org"                          # Your HTTP server, Apache/etc
role :app, "blog.hogel.org"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

ADDRESS = "127.0.0.1"
PORT = 3331

role :db,  "blog.hogel.org", primary: true
task :db_setup, roles: [:db] do
  run "mkdir -p -m 755 #{shared_path}/db"
end

set :deploy_to, "/home/blog/app"
set :use_sudo, false

set :rbenv_ruby_version, "2.0.0-p247"
set :default_environment, {
  "RBENV_ROOT" => "#{rbenv_path}",
  "PATH" => "#{rbenv_path}/shims:#{rbenv_path}/bin:$PATH"
}

THIN_CONF = File.join(current_path, "config", "thin.yml")
THIN_PARAM = "-C #{THIN_CONF} --port #{PORT} --address #{ADDRESS} -e production"
THIN_CMD = "cd #{current_path}; bundle exec thin #{THIN_PARAM}"
namespace :deploy do
  task :start, roles: :app do
    run "#{THIN_CMD} start"
  end
  task :stop, roles: :app do
    run "#{THIN_CMD} stop"
  end
  task :restart, roles: :app do
    run "#{THIN_CMD} restart"
  end
end
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
