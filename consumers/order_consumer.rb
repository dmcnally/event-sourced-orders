require 'racecar'
require 'oj'
require_relative '../models/order'

class OrderConsumer < Racecar::Consumer
  subscribes_to "#{ENV['KAFKA_PREFIX']}orders", start_from_beginning: true

  def process(message)
    message_value = Oj.load(message.value)

    # find our order, or initialize a new one
    order = Order.where(id: message_value.fetch('order_id')).first_or_initialize

    # add our attributes
    order.line_items = message_value.fetch('line_items')
    order.created_at = message_value.fetch('timestamp')
    order.total = message_value.fetch('line_items').map { |li|
      Integer(li.fetch('price')) * Integer(li.fetch('quantity'))
    }.reduce(:+)

    # persist the order
    order.save!
  rescue KeyError => e
    raise KeyError, "#{e.message}\nMessage: #{message_value.inspect}"
  end
end
