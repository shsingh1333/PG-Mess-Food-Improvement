class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :customized_food

  def total_price
    customized_food.price * quantity
  end
end
