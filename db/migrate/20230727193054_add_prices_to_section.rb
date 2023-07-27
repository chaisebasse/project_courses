class AddPricesToSection < ActiveRecord::Migration[7.0]
  def change
    add_monetize :sections, :price
  end
end
