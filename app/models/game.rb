class Game < ApplicationRecord
    has_many :comments
    has_many :users, through: :comments

    validate :not_a_duplicate 
    validates :name, presence: true  
    validates :genre, presence: true 
end
