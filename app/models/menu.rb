class Menu < ApplicationRecord
    validates :name, presence: true, uniqueness: true, length: {minimum: 4}
    has_and_belongs_to_many :dishes
end
