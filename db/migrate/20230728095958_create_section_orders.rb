class CreateSectionOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :section_orders do |t|
      t.string :state
      t.string :section_sku
      t.monetize :amount
      t.string :checkout_session_id
      t.references :user, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
