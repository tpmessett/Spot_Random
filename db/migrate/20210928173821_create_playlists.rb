class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :listid
      t.string :trackid, array: true, default: []
      t.timestamps
    end
  end
end
