class Admin::HomeController < ApplicationController
layout 'admin_layout'
				
		def show
								@battles = Battle.order("created_at DESC").all
						@users = User.find(:all, :limit => 10, :order=> 'created_at desc')
		end
end
