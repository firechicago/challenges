class AddTelevisionShowIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :television_show_id, :integer, null: false

    add_index :characters, [:character_name, :television_show_id], unique: true
  end
end
