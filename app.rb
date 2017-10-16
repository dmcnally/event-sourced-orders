require 'sinatra'
require 'rack/ssl'

require_relative 'models/order'

configure :production do
  use Rack::SSL
end

configure do
  set :server, :puma
end

get '/' do
  erb :order_index, locals: { orders: Order.order('created_at desc') }
end
