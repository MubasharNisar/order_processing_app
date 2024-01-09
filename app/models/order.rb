# app/models/order.rb
class Order < ApplicationRecord
  enum order_type: { buy: 0, sell: 1 }
  enum status: { pending: 0, completed: 1, canceled: 2 }


  scope :completed_buy_orders, -> { where(order_type: :buy, status: :completed) }

  def self.process_order(order)
    begin
      if order.buy? && order.price < specified_buy_threshold
        order.update(status: :completed)
      elsif order.sell? && order.price > specified_sell_threshold
        order.update(status: :completed)
      else
        order.update(status: :canceled)
      end
    rescue StandardError => e
      Rails.logger.error("Error processing order: #{e.message}")
    end
  end

  def self.total_completed_quantity_for_user(user_id)
    where(user_id: user_id, status: :completed).sum(:quantity)
  end

  private

  def self.specified_buy_threshold
    100
  end

  def self.specified_sell_threshold
    500
  end
end

