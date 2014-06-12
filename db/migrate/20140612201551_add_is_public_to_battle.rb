class AddIsPublicToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :is_public, :boolean ,:default => 0
  end
end
