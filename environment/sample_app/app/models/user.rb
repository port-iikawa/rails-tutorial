class User < ApplicationRecord
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
    uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }
    validates :password_confirmation, presence: true

end