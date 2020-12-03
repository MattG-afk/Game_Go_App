class Game < ApplicationRecord

    #originally comment was join table decided games makes more sense
    has_many :comments
    has_many :users, through: :comments
    #belongs_to :user
    #belongs_to :comment 

    has_many :genres
    has_many :names
    has_many :descriptions

    accepts_nested_attributes_for :comments

    validates :name, presence: true  
    validates :genre, presence: true
    validates :name, length: {maximum: 250}
    validates :description, length: {maximum:2000}

end
