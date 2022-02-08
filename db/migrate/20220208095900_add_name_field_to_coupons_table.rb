class AddNameFieldToCouponsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :name, :string
  end
end
