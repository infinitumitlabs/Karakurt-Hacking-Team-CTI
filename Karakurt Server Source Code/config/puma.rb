project_path = ENV.fetch("RAILS_ENV") == 'development' ? Rails.root : '/var/www/panel'

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }

threads min_threads_count, max_threads_count

port ENV.fetch("PORT") { 3050 }
environment ENV.fetch("RAILS_ENV") { "development" }
pidfile ENV.fetch("PIDFILE") { "#{project_path}/tmp/pids/server.pid" }
bind "unix://#{project_path}/tmp/sockets/puma.sock"
stdout_redirect "#{project_path}/log/puma.stdout.log", "#{project_path}/log/puma.stderr.log", true

plugin :tmp_restart
