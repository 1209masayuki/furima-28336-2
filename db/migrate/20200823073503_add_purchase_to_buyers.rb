class AddPurchaseToBuyers < ActiveRecord::Migration[6.0]
  def change
    add_reference :buyers, :purchase, null: false, foreign_key: true
  end
end
