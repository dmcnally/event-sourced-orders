require 'racecar'
require_relative '../consumers/order_consumer'

Racecar.config.tap do |config|
  config.brokers = ENV.fetch('KAFKA_URL').split(','),
  config.client_id = "#{ENV['KAFKA_PREFIX']}orders",
  config.ssl_ca_cert = ENV['KAFKA_TRUSTED_CERT'],
  config.ssl_client_cert = ENV['KAFKA_CLIENT_CERT'],
  config.group_id_prefix = "#{ENV['KAFKA_PREFIX']}orders",
  config.ssl_client_cert_key = ENV['KAFKA_CLIENT_CERT_KEY'],
  config.max_wait_time = 2
end
