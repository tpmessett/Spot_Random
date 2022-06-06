class AddExpiry < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :expiry, :bigint;
  end
end
