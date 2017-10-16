require 'racecar'
require 'oj'
require_relative '../models/order'

class OrderConsumer < Racecar::Consumer
  subscribes_to "#{ENV['KAFKA_PREFIX']}orders"

  def process(message)
    message_value = Oj.load(message.value)

    Order.create!({
      id:         message_value.fetch('order_id'),
      line_items: message_value.fetch('line_items'),
      created_at: message_value.fetch('timestamp')
    })
  end
end
