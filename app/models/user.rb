class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :purchases

  zenkaku = /\A[ぁ-んァ-ン一-龥]/
  zenkaku_kana = /\A[ァ-ヶー－]+\z/
  validates :birth_date, presence: true
  with_options presence: true do
    validates :nickname, length: { maximum: 40 }
    validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: 'Password Include both letters numbers' }
    validates :first_name, format: { with: zenkaku, message: 'First name Full-width characters' }
    validates :last_name, format: { with: zenkaku, message: 'Last name Full-width characters' }
    validates :first_name_kana, format: { with: zenkaku_kana, message: 'First name kana Full-width katakana characters' }
    validates :last_name_kana, format: { with: zenkaku_kana, message: 'Last name kana Full-width katakana characters' }
  end
end