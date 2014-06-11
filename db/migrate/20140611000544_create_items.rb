class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :vote_count
      t.integer :battle_id
      t.timestamps
    end
  end
end
