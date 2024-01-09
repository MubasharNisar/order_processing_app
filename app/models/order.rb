# app/models/order.rb
class Order < ApplicationRecord
  enum order_type: { buy: 0, sell: 1 }
  enum status: { pending: 0, completed: 1, canceled: 2 }
end

