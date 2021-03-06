class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :managements

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々]+\z/
  VALID_NAME_F_REGEX = /\A[ァ-ヶー－]+\z/
  with_options presence: true do
    validates :nickname, format: { with: /\A[a-z0-9]+\z/i }
    validates :last_name, format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
    validates :first_name, format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
    validates :last_name_f, format: { with: VALID_NAME_F_REGEX, message: 'は全角カタカナで入力してください' }
    validates :first_name_f, format: { with: VALID_NAME_F_REGEX, message: 'は全角カタカナで入力してください' }
    validates :birthday
  end
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
end
