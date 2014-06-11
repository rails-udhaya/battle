class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string :title
      t.text :description
      t.integer :total_vote_count
      t.timestamps
    end
  end
end
