class User < ApplicationRecord
    validates :username, uniqueness: true
    validates_presence_of   :email, presence: true, uniqueness: true, :message => 'Please Enter your Email.'
    validates_presence_of   :password, presence: true, uniqueness: true, :message => 'Please Enter Your Password.'
    has_secure_password
    has_many :games
    has_many :comments, through: :games

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
            user.user_name = auth.info.name
            user.email = auth.info.email]
            user.password = SecureRandom.hex
        end
    end

end
