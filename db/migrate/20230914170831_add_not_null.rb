class AddNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :title, :false
    change_column_null :products, :description, :false
    change_column_null :products, :price, :false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
