class Game < ApplicationRecord

    #originally comment was join table decided games makes more sense
    has_many :comments
    has_many :users, through: :comments
    #belongs_to :user
    #belongs_to :comment 

    accepts_nested_attributes_for :comments

    scope :search_by_name, -> (search_name){where("name = ?", search_name)}

    validates :name, presence: true  
    validates :genres, presence: true
    validates :name, length: {maximum: 250}
    validates :description, length: {maximum:2000}

end
