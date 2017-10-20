require 'racecar'
require 'oj'
require_relative '../models/order'

class OrderConsumer < Racecar::Consumer
  subscribes_to "#{ENV['KAFKA_PREFIX']}orders", start_from_beginning: true

  def process(message)
    message_value = Oj.load(message.value)

    order = Order.where(id: message_value.fetch('order_id')).first_or_create!({
      line_items: message_value.fetch('line_items').map { |li|
        { 'quantity' => Integer(li['quantity']) * 2, 'title' => li['title'] }
      },
      created_at: message_value.fetch('timestamp')
    })
  end
end
