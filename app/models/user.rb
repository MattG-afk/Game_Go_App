class User < ApplicationRecord
    validates :username, uniqueness: true
    validates_presence_of   :email, presence: true, uniqueness: true, :message => 'Please Enter your Email.'
    validates_presence_of   :password, presence: true, uniqueness: true, :message => 'Please Enter Your Password.'
    has_secure_password
    has_many :games
    has_many :comments, through: :games

    def self.from_omniauth(auth)
        self.find_or_create_by(username: auth[:info][:email]) do |user|
          user.email = auth[:info][:email]
          user.password = SecureRandom.hex
        end
    end

end
