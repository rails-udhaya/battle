class Battle < ActiveRecord::Base
  attr_accessible :title,:description,:main_asset
  
  has_attached_file :main_asset, :styles =>{ :main=>"680*470>" ,:medium => "400x304>", :thumb => "100x100>" }, :default_url => "/assets/no-asset.jpg"
  validates_attachment_content_type :main_asset, :content_type => /\Aimage\/.*\Z/
  
  
  has_many :items
end
