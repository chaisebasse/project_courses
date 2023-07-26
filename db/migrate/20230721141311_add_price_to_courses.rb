class AddPriceToCourses < ActiveRecord::Migration[7.0]
  def change
    add_monetize :courses, :price
  end
end
