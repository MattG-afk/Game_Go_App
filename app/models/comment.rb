class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :game 

    #has_many :games
    #has_many :users, through: :games

    validates :content, length: {maximum: 250} 
    validates :stars, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6}


    validates :content, uniqueness: { scope: :user, message: "has already been commented on"  }
end
