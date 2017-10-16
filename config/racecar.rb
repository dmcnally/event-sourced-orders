require 'racecar'
require 'logger'

require_relative 'consumers/order_consumer'

Racecar.config.load({
  brokers: ENV.fetch('KAFKA_URL').split(','),
  client_id: "#{ENV['KAFKA_PREFIX']}orders",
  ssl_ca_cert: ENV['KAFKA_TRUSTED_CERT'],
  ssl_client_cert: ENV['KAFKA_CLIENT_CERT'],
  group_id_prefix: "#{ENV['KAFKA_PREFIX']}orders",
  ssl_client_cert_key: ENV['KAFKA_CLIENT_CERT_KEY'],
  max_wait_time: 2
})

Racecar.logger = Logger.new($stdout)
