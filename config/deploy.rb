set :application, "blog"
set :repo_url,  "git@github.com:hogelog/blog.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

ADDRESS = "127.0.0.1"
PORT = 3331

set :deploy_to, "/home/blog/app"
set :use_sudo, false

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, "2.0.0-p247"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails thin}
set :rbenv_roles, :all # default value
#set :default_environment, {
#  "RBENV_ROOT" => "#{rbenv_path}",
#  "PATH" => "#{rbenv_path}/shims:#{rbenv_path}/bin:$PATH"
#}

THIN_CONF = File.join(current_path, "config", "thin.yml")
THIN_PARAM = "-C #{THIN_CONF} --port #{PORT} --address #{ADDRESS} -e production"
THIN_CMD = "exec thin #{THIN_PARAM}"

namespace :deploy do
  desc "Start app server"
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute :bundle, "#{THIN_CMD} start"
      end
    end
  end

  desc "Stop app server"
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute :bundle, "#{THIN_CMD} stop"
      end
    end
  end

  desc "Restart app server"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute :bundle, "#{THIN_CMD} restart"
      end
    end
  end

  desc "Copy .env"
  task :dotenv do
    on roles(:app), in: :sequence do
      within release_path do
        execute :cp, shared_path.join(".env"), "."
      end
    end
  end

  after :finishing, 'deploy:cleanup'
  before :migrate, 'deploy:dotenv'
end
