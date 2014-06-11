class AddAssetFieldsToItem < ActiveRecord::Migration
  def self.up
    add_attachment :items, :asset
  end

  def self.down
    remove_attachment :items, :asset
  end
end
