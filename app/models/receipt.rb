class Receipt < ApplicationRecord
  before_create :set_remaining_meal
  belongs_to :student

  validates :total_meal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :remaining_meal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :remaining_meal_cannot_exceed_total_meal


  
    def set_remaining_meal
      self.remaining_meal = self.total_meal
    end
  

  
    def extend_meal
      update(remaining_meal: remaining_meal + 1)
    end


    def remaining_meal_cannot_exceed_total_meal
      if remaining_meal.present? && total_meal.present? && remaining_meal > total_meal
        errors.add(:remaining_meal, "cannot be greater than total meals")
      end
    end
  
    def self.decrease_remaining_meal
      where("remaining_meal > 0").update_all("remaining_meal = remaining_meal - 1")
    end



end
