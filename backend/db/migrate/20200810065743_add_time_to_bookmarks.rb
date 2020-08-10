class AddTimeToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :time, :float
  end
end
