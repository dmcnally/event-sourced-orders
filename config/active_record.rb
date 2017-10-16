require 'active_record'
require 'yaml'
require 'erb'

db_config = YAML::load(ERB.new(File.read('db/config.yml')).result).fetch(ENV.fetch('APP_ENV', 'development'))
ActiveRecord::Base.establish_connection(db_config)
