class Battle < ActiveRecord::Base
  attr_accessible :title,:description,:main_asset
  
  has_attached_file :main_asset, :styles =>{:medium => "300x400>", :thumb => "200x200>" }, :default_url => "/assets/no-asset.jpg"
  validates_attachment_content_type :main_asset, :content_type => /\Aimage\/.*\Z/
  
  
  has_many :items
end
