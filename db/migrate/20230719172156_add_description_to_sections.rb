class AddDescriptionToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :description, :text
  end
end
