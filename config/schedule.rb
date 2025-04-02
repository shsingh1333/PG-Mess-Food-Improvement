env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']





# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever



set :output, "/home/shivamsingh/Desktop/ruby_training/pg_mess/pg_mess_food_improvement/log/cron_debug.log"

every 1.day, at: ['08:00 am', '12:30 pm', '08:00 pm'] do
  runner "Receipt.decrease_remaining_meal"
end

