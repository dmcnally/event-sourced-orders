# ENV["DB"] is used by standalone migrations during rake tasks. This is
# a way of allowing us to just specify environment once in APP_ENV.
ENV["DB"] = ENV.fetch("RACK_ENV", "development")

require 'standalone_migrations'
require_relative 'config/active_record'

StandaloneMigrations::Tasks.load_tasks
