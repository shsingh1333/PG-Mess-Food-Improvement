class Cart < ApplicationRecord
    has_many :line_items, :dependent => :destroy

    def add_product(customized_food_id)
        current_item = line_items.find_by_customized_food_id(customized_food_id)
        if current_item
            current_item.quantity += 1
        else
            current_item = line_items.build(:customized_food_id => customized_food_id)
        end
        current_item
    end
    
    def total_price
        line_items.to_a.sum { |item| item.total_price }
    end 
end
