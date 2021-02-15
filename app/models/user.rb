class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, format: { with: /\A[a-z0-9]+\z/i }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'Full-width characters.' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]\z/, message: 'Full-width characters.' }
    validates :last_name_f, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters.' }
    validates :first_name_f, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters.' }
    validates :birthday
  end
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
end
