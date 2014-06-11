class Battle < ActiveRecord::Base
  attr_accessible :title,:description
  
  has_many :items
end
