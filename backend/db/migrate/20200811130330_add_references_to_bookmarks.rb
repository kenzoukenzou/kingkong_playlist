class AddReferencesToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookmarks, :playlist, foreign_key: true
  end
end
