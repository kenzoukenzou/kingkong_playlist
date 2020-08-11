class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :title, null: false
      t.text :description
      t.string :thumbnail

      t.timestamps
    end
  end
end
