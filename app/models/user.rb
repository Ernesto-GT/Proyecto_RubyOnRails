class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true,
        format: {
            with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
            message: "invalido"
        }
    validates :username, presence: true, uniqueness: true, length: {in: 3..15},
        format: {
            with: /\A[a-z0-9A-Z]+\z/,
            message: "invalido"
        }
    validates :phone, presence: true, uniqueness: true
    validates :password, length: {minimum:6, maximum:20}, if: :password_digest_changed?

    has_many :products, dependent: :destroy
    has_many :favorites, dependent: :destroy
    before_save :downcase_atributes 

    private 
    def downcase_atributes
        self.username = username.downcase
        self.email = email.downcase
    end
end
