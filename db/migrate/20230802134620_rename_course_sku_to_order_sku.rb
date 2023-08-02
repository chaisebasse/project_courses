class RenameCourseSkuToOrderSku < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :course_sku, :order_sku
  end
end
