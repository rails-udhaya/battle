class Admin::UsersController < ApplicationController
		layout 'admin_layout'		
		  before_filter :admin_only!		
				
		def index
				@users =  User.find(:all , :order=> 'created_at desc')
		end
		
end
