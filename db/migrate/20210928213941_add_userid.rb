class AddUserid < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :user_id, :integer
  end
end
