class AddAddressesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :string
    add_reference :users, :province, foreign_key: true
  end
end
