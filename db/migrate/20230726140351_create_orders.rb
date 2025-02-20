class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :state
      t.string :order_sku
      t.monetize :amount
      t.string :checkout_session_id
      t.references :user, null: false, foreign_key: true
      t.references :purchasable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
