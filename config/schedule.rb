# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.

set :output, '/log/cron_log.log'

every 1.day, at: '4:00 am' do
  rake 'update_rls'
end
