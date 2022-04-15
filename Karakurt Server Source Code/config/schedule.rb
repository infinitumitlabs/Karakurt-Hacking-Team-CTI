# set :environment, :development
set :output, "log/whenever.log"

every 1.minutes do
  # runner "app/lib/tasks/filer.rb"
  runner "Tasks::Filer.new.perform"
end