class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.text :content, null: false
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
