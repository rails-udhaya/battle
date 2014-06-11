class HomeController < ApplicationController
		
		def index
				if current_user && current_user.role == "admin"
							redirect_to  admin_home_path
					end
			end
			
end
