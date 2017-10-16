require 'racecar'
require 'oj'
require_relative '../models/order'

class OrderConsumer < Racecar::Consumer
  subscribes_to "#{ENV['KAFKA_PREFIX']}orders", start_from_beginning: true

  def process(message)
    $stdout.puts "Received message: #{message.inspect}"

    message_value = Oj.load(message.value)

    Order.where(id: message_value.fetch('order_id')).first_or_create!({
      line_items: message_value.fetch('line_items'),
      created_at: message_value.fetch('timestamp')
    })
  end
end
