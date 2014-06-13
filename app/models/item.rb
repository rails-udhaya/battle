class Item < ActiveRecord::Base
  attr_accessible :title, :asset
  has_attached_file :asset, :styles => {:main=>"680x470>", :thumb => "100x100#", :medium =>"400x400#" }, :default_url => "/assets/no-asset.jpg"
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/
    
  acts_as_commentable
  
  belongs_to :battle
end
