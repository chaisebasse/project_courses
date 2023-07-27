class AddSkuToSection < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :sku, :string
  end
end
