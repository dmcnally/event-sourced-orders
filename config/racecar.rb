require 'racecar'
require_relative '../consumers/order_consumer'

module Racecar
  module RailsConfigFileLoader
    def self.load!
      # no-op
    end
  end
end

$stdout.puts "Configuring Racecar"
begin
  Racecar.config.tap do |config|
    config.brokers = ENV.fetch('KAFKA_URL').split(',')
    config.client_id = "#{ENV['KAFKA_PREFIX']}orders"
    config.ssl_ca_cert = ENV['KAFKA_TRUSTED_CERT']
    config.ssl_client_cert = ENV['KAFKA_CLIENT_CERT']
    #config.group_id_prefix = "#{ENV['KAFKA_PREFIX']}orders-"
    config.group_id = "#{ENV['KAFKA_PREFIX']}orders-order-consumer-v2"
    config.ssl_client_cert_key = ENV['KAFKA_CLIENT_CERT_KEY']
    config.max_wait_time = 1
    config.log_level = 'debug'
  end

  $stdout.puts "Configured Racecar"
rescue Exception => ex
  $stderr.puts ex.message
  $stderr.puts ex.backtrace
  raise
end
