class AddSkuToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :sku, :string
  end
end
