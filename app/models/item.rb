class Item < ActiveRecord::Base
  attr_accessible :title, :asset
  
  has_attached_file :asset, :styles => { :main=>"680*470>" ,:medium => "400x304>", :thumb => "100x100>" }, :default_url => "/assets/no-asset.jpg"
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :battle
end
