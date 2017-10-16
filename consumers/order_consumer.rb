require 'racecar'
require 'oj'
require_relative '../models/order'

class OrderConsumer < Racecar::Consumer
  subscribes_to "#{ENV['KAFKA_PREFIX']}orders", start_from_beginning: true

  def process(message)
    $stdout.puts "Received message: #{message.inspect}"
  end
end
