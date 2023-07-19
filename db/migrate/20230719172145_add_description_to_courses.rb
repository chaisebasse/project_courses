class AddDescriptionToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :description, :text
  end
end
