class BuyerPurchase
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :purchase_id, :postal_code, :prefecture_id, :city, :addresses, :phone_num, :building

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :phone_num, :token, presence: true
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Buyer.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, phone_num: phone_num, building: building, purchase_id: purchase.id)
  end
end
