class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{8,}\z/i.freeze

  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: { case_sensitive: false},
                      format: { with: EMAIL_REGEX}
    validates :password, length: { minimum: 8}, format: { with: PASSWORD_REGEX }
  end
  validates :password_confirmation, confirmation: true 
end
