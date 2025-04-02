class Student < ApplicationRecord
    has_many:receipt
    validates :email, presence: true, uniqueness: true
end
