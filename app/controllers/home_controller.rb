class HomeController < ApplicationController
		
		def index
				@battles =Battle.where('is_public = ?', true).order('created_at DESC').limit(20)
				if current_user && current_user.role == "admin"
							redirect_to  admin_home_path
					end
			end
			
end
