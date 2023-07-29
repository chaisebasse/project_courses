class AddPurchasableToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :purchasable, polymorphic: true, null: false
  end
end
