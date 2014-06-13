class AddMainAssetToBattle < ActiveRecord::Migration
    def self.up
    add_attachment :battles, :main_asset
  end

  def self.down
    remove_attachment :battles, :main_asset
  end
end
