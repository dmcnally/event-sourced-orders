require 'racecar'
require 'oj'
require_relative '../models/order'

class OrderConsumer < Racecar::Consumer
  subscribes_to "#{ENV['KAFKA_PREFIX']}orders", start_from_beginning: true

  def process(message)
    $stdout.puts "Received message: #{message.inspect}"

    begin
      message_value = Oj.load(message.value)
    rescue Exception => ex
      $stdout.puts ex.message
      $stdout.puts ex.backtrace
      return true
    end

    order = Order.where(id: message_value.fetch('order_id')).first_or_create!({
      line_items: message_value.fetch('line_items'),
      created_at: message_value.fetch('timestamp')
    })

    $stdout.puts "Created order ##{order.id}"
  rescue Exception => ex
    $stdout.puts ex.message
    $stdout.puts ex.backtrace
    raise
  end
end
