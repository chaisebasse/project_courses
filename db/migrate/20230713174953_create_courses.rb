class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :sku
      t.string :color

      t.timestamps
    end
  end
end
